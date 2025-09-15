import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/shared/components/custom_snack_bar.dart';
import 'package:flutter_note_app/presentation/note/bloc/create_note_cubit.dart';
import 'package:flutter_note_app/presentation/note/widget/create_note_app_bar.dart';
import 'package:flutter_note_app/presentation/note/widget/note_input_widget.dart';
import 'package:flutter_note_app/core/utils/app_validators.dart';
import 'package:flutter_note_app/presentation/note/widget/ai_keywords_section_widget.dart';
import 'package:flutter_note_app/presentation/note/widget/ai_summary_section_widget.dart';
import 'package:flutter_note_app/core/init/di_container.dart';
import 'package:flutter_note_app/domain/usecases/note/create_note_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/update_note_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/generate_keywords_usecase.dart';
import 'package:flutter_note_app/domain/usecases/note/generate_summary_usecase.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({super.key, this.note});

  final NoteEntity? note;

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider<CreateNoteCubit>(
      create: (context) {
        final cubit = CreateNoteCubit(
          createNoteUseCase: getIt<CreateNoteUseCase>(),
          updateNoteUseCase: getIt<UpdateNoteUseCase>(),
          generateKeywordsUseCase: getIt<GenerateKeywordsUseCase>(),
          generateSummaryUseCase: getIt<GenerateSummaryUseCase>(),
        );
        if (widget.note != null) {
          cubit.initializeForEdit(widget.note!);
        }
        return cubit;
      },
      child: BlocConsumer<CreateNoteCubit, CreateNoteState>(
        listener: (context, state) {
          if (state is NoteSuccess) {
            CustomSnackBar.showSuccess(context, StringConstants.noteSaveSuccess);
            context.pop();
          } else if (state is NoteFailure) {
            CustomSnackBar.showError(context, state.message);
          } else if (state is NoteShowExitDialog) {
            _showExitDialog();
          } else if (state is NoteGoBack) {
            context.pop();
          } else if (state is NoteValidationError) {
            CustomSnackBar.showError(context, state.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: const CreateNoteAppBar(),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    // Title Input
                    BlocBuilder<CreateNoteCubit, CreateNoteState>(
                      builder: (context, state) {
                        final cubit = context.read<CreateNoteCubit>();
                        return NoteInputWidget(
                          controller: cubit.titleController,
                          focusNode: FocusNode(),
                          type: NoteInputType.title,
                          onSubmitted: () => FocusScope.of(context).nextFocus(),
                          validator: AppValidators.noteTitleValidator,
                        );
                      },
                    ),

                    SizedBox(height: 10.h),

                    // Content Input
                    BlocBuilder<CreateNoteCubit, CreateNoteState>(
                      builder: (context, state) {
                        final cubit = context.read<CreateNoteCubit>();
                        return NoteInputWidget(
                          controller: cubit.contentController,
                          focusNode: FocusNode(),
                          type: NoteInputType.content,
                        );
                      },
                    ),

                    SizedBox(height: 10.h),

                    // AI Keywords Section
                    BlocBuilder<CreateNoteCubit, CreateNoteState>(
                      builder: (context, state) {
                        final cubit = context.read<CreateNoteCubit>();
                        return AIKeywordsSectionWidget(
                          controller: cubit.keywordsController,
                          content: cubit.contentController.text,
                        );
                      },
                    ),

                    SizedBox(height: 10.h),

                    // AI Summary Section
                    BlocBuilder<CreateNoteCubit, CreateNoteState>(
                      builder: (context, state) {
                        final cubit = context.read<CreateNoteCubit>();
                        return AISummarySectionWidget(
                          controller: cubit.summaryController,
                          content: cubit.contentController.text,
                        );
                      },
                    ),

                    SizedBox(height: 10.h),

                    // Auto-save indicator
                    BlocBuilder<CreateNoteCubit, CreateNoteState>(
                      builder: (context, state) {
                        final cubit = context.read<CreateNoteCubit>();
                        if (!cubit.hasUnsavedChanges()) return const SizedBox.shrink();
                        return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer.withValues(
                            alpha: 0.3,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: colorScheme.primary.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              size: 14.w,
                              color: colorScheme.primary,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              StringConstants.noteUnsavedChanges,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: 11.sp,
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showExitDialog() {
    final cubit = context.read<CreateNoteCubit>();
    if (!cubit.hasUnsavedChanges()) {
      context.pop();
      return;
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: colorScheme.surface,
        title: Text(
          StringConstants.noteExitDialogTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        content: Text(
          StringConstants.noteExitDialogContent,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              StringConstants.noteExitDialogCancel,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop();
            },
            child: Text(
              StringConstants.noteExitDialogExit,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                color: colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
