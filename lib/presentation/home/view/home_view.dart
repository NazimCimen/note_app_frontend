import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/presentation/home/widget/home_app_bar.dart';
import 'package:flutter_note_app/presentation/home/widget/note_card.dart';
import 'package:flutter_note_app/presentation/home/widget/note_search_bar.dart';
import 'package:flutter_note_app/presentation/home/widget/filter_sort_bar.dart';
import 'package:flutter_note_app/presentation/home/bloc/home_cubit.dart';
import 'package:flutter_note_app/presentation/home/bloc/home_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_note_app/presentation/home/widget/no_item_widget.dart';
import 'package:flutter_note_app/presentation/home/widget/home_error_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().loadNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.paginationState.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.paginationState.error.toString()),
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

              const SliverToBoxAdapter(child: NoteSearchBar()),

              const SliverToBoxAdapter(child: FilterSortBar()),

              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: PagedSliverList<int, NoteEntity>(
                  state: state.paginationState,
                  fetchNextPage: cubit.fetchNextPage,
                  builderDelegate: PagedChildBuilderDelegate<NoteEntity>(
                    itemBuilder: (context, note, index) => NoteCard(note: note),
                    firstPageErrorIndicatorBuilder: (context) =>
                        HomeErrorWidget(reload: () => cubit.loadNotes()),
                    newPageErrorIndicatorBuilder: (context) => Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () => cubit.fetchNextPage(),
                          child: Text(StringConstants.homeRetryButton),
                        ),
                      ),
                    ),

                    
                    noItemsFoundIndicatorBuilder: (context) =>
                        const NoItemWidget(),
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
