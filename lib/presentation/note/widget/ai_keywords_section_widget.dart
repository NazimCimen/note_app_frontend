import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_note_app/presentation/note/bloc/create_note_cubit.dart';
import 'package:flutter_note_app/shared/components/custom_snack_bar.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

class AIKeywordsSectionWidget extends StatelessWidget {
  final TextEditingController controller;
  final String content;

  const AIKeywordsSectionWidget({
    required this.controller,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocConsumer<CreateNoteCubit, CreateNoteState>(
      listener: (context, state) {
        if (state is NoteKeywords) {
          controller.text = state.keywords;
        } else if (state is NoteKeywordsReset) {
          controller.clear();
        } else if (state is NoteKeywordsFailure) {
          CustomSnackBar.showError(context, state.message);
        }
      },
      builder: (context, state) {
        final isGenerating = state is NoteKeywordsLoading;
        
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.tag_outlined,
                    size: 18.w,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    StringConstants.keywords,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: isGenerating ? null : () {
                      final locale = context.locale.languageCode;
                      context.read<CreateNoteCubit>().generateKeywords(content, locale);
                    },
                    icon: isGenerating
                        ? SizedBox(
                            width: 14.w,
                            height: 14.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                colorScheme.primary,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.auto_awesome,
                            size: 16.w,
                            color: colorScheme.primary,
                          ),
                    label: Text(
                      isGenerating ? StringConstants.generating : StringConstants.generateKeywords,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 11.sp,
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: controller,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 13.sp,
                  color: colorScheme.onSurface,
                  height: 1.3,
                ),
                decoration: InputDecoration(
                  hintText: StringConstants.keywordsHint,
                  hintStyle: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 13.sp,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                maxLines: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
