import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

enum NoteInputType {
  title,
  content,
}

class NoteInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final NoteInputType type;
  final VoidCallback? onSubmitted;
  final String? Function(String?)? validator;

  const NoteInputWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.type,
    this.onSubmitted,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isTitle = type == NoteInputType.title;
    final height = isTitle ? null : 200.h;
    final maxLines = isTitle ? 2 : null;
    final textInputAction = isTitle ? TextInputAction.next : TextInputAction.newline;
    final textAlignVertical = isTitle ? null : TextAlignVertical.top;
    final hintText = isTitle ? StringConstants.noteTitleHint : StringConstants.noteContentHint;
    final fontSize = isTitle ? 15.sp : 13.sp;
    final fontWeight = isTitle ? FontWeight.w500 : FontWeight.w400;

    return Container(
      height: height,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: theme.textTheme.titleMedium?.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: theme.textTheme.titleMedium?.copyWith(
            fontSize: fontSize,
            color: colorScheme.onSurface.withValues(alpha: 0.5),
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          errorText: validator != null ? validator!(controller.text) : null,
        ),
        maxLines: maxLines,
        textInputAction: textInputAction,
        textAlignVertical: textAlignVertical,
        onSubmitted: onSubmitted != null ? (_) => onSubmitted!() : null,
      ),
    );
  }
}

