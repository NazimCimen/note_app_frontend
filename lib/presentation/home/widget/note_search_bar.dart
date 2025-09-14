import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_note_app/presentation/home/bloc/search_type.dart';

class NoteSearchBar extends StatefulWidget {
  const NoteSearchBar({
    required this.searchController,
    this.onSearchTypeChanged,
    this.currentSearchType = SearchType.both,
    super.key,
  });

  final TextEditingController searchController;
  final ValueChanged<SearchType>? onSearchTypeChanged;
  final SearchType currentSearchType;

  @override
  State<NoteSearchBar> createState() => _NoteSearchBarState();
}

class _NoteSearchBarState extends State<NoteSearchBar> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_onTextChanged);
    _hasText = widget.searchController.text.isNotEmpty;
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = widget.searchController.text.isNotEmpty;
    if (_hasText != hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
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
                controller: widget.searchController,
                onChanged: (value) => {},
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: 'Notlarda ara...',
                  hintStyle: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    size: 18.w,
                    color: colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                  suffixIcon: _hasText
                      ? GestureDetector(
                          onTap: () {
                            widget.searchController.clear();
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
                  'Arama türü:',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<SearchType>(
                      value: widget.currentSearchType,
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
                          widget.onSearchTypeChanged?.call(value);
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
