import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/presentation/home/bloc/home_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_note_app/presentation/home/bloc/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

class NoteSearchBar extends StatefulWidget {
  const NoteSearchBar({super.key});

  @override
  State<NoteSearchBar> createState() => _NoteSearchBarState();
}

class _NoteSearchBarState extends State<NoteSearchBar> {
  TextEditingController searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    // Initialize search controller with current search query
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentQuery = context.read<HomeCubit>().state.searchQuery ?? '';
      if (searchController.text != currentQuery) {
        searchController.text = currentQuery;
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.2),
                width: 0.5,
              ),
            ),
            child: Center(
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  _debounceTimer?.cancel();
                  _debounceTimer = Timer(const Duration(milliseconds: 500), () {
                    context.read<HomeCubit>().updateSearchQuery(value);
                  });
                },
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: StringConstants.homeSearchHint,
                  hintStyle: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    size: 18.w,
                    color: colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                  suffixIcon: searchController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _debounceTimer?.cancel();
                            searchController.clear();
                            context.read<HomeCubit>().updateSearchQuery('');
                          },
                          child: Icon(
                            Icons.close_rounded,
                            size: 18.w,
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.1),
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.tune_outlined,
                  size: 16.w,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                SizedBox(width: 8.w),
                Text(
                  StringConstants.homeSearchType,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<SearchType>(
                      value: context.watch<HomeCubit>().state.searchType,
                      isDense: true,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                      dropdownColor: colorScheme.surface,
                      items: SearchType.values.map((SearchType type) {
                        return DropdownMenuItem<SearchType>(
                          value: type,
                          child: Text(type.displayName),
                        );
                      }).toList(),
                      onChanged: (SearchType? value) {
                        if (value != null) {
                          context.read<HomeCubit>().updateSearchType(value);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
