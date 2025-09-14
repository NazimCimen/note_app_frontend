import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteFilterBar extends StatelessWidget {
  const NoteFilterBar({
    required List<String> filterOptions,
    required String selectedFilter,
    this.onFilterChanged,
    super.key,
  }) : _filterOptions = filterOptions,
       _selectedFilter = selectedFilter;

  final List<String> _filterOptions;
  final String _selectedFilter;
  final void Function(String)? onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: _filterOptions.length,
        itemBuilder: (context, index) {
          final filter = _filterOptions[index];
          final isSelected = _selectedFilter == filter;

          return GestureDetector(
            onTap: () => onFilterChanged?.call(filter),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Center(
                child: Text(
                  filter,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? Theme.of(context).colorScheme.surface
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
