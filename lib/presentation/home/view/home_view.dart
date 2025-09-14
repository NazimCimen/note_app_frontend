import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/presentation/home/widget/home_app_bar.dart';
import 'package:flutter_note_app/presentation/home/widget/note_card.dart';
import 'package:flutter_note_app/presentation/home/widget/note_search_bar.dart';
import 'package:flutter_note_app/presentation/home/widget/filter_sort_bar.dart';
import 'package:flutter_note_app/presentation/home/bloc/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_note_app/presentation/home/widget/no_item_widget.dart';
import 'package:flutter_note_app/presentation/home/widget/home_error_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().loadNotes();
    });
    
    // Listen to search input changes
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  /// Handle search input changes with debouncing
  void _onSearchChanged() {
    // Simple debouncing can be added here if needed
    final query = _searchController.text;
    context.read<HomeCubit>().updateSearchQuery(query);
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, PagingState<int, NoteEntity>>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        
        return RefreshIndicator(
          onRefresh: () => cubit.refreshNotes(),
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                expandedHeight: 0,
                pinned: true,
                flexibleSpace: HomeAppBar(),
                automaticallyImplyLeading: false,
                forceMaterialTransparency: true,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
              ),

              SliverToBoxAdapter(
                child: BlocBuilder<HomeCubit, PagingState<int, NoteEntity>>(
                  builder: (context, state) {
                    final cubit = context.read<HomeCubit>();
                    return NoteSearchBar(
                      searchController: _searchController,
                      currentSearchType: cubit.currentSearchType,
                      onSearchTypeChanged: (searchType) {
                        cubit.updateSearchType(searchType);
                      },
                    );
                  },
                ),
              ),

              // Filter and Sort Section
              const SliverToBoxAdapter(
                child: FilterSortBar(),
              ),

              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: PagedSliverList<int, NoteEntity>(
                  state: state,
                  fetchNextPage: cubit.fetchNextPage,
                  builderDelegate: PagedChildBuilderDelegate<NoteEntity>(
                    itemBuilder: (context, note, index) => NoteCard(note: note),
                    firstPageErrorIndicatorBuilder: (context) => HomeErrorWidget(
                      reload: () => cubit.loadNotes(),
                    ),
                    newPageErrorIndicatorBuilder: (context) => Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () => cubit.fetchNextPage(),
                          child: const Text('Tekrar Dene'),
                        ),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (context) => const NoItemWidget(),
                    firstPageProgressIndicatorBuilder: (context) => 
                        const Center(child: CircularProgressIndicator()),
                    newPageProgressIndicatorBuilder: (context) => Padding(
                      padding: EdgeInsets.all(16.w),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
