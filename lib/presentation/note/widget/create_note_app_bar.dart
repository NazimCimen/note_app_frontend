import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/presentation/note/bloc/create_note_cubit.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

class CreateNoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CreateNoteAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<CreateNoteCubit, CreateNoteState>(
      builder: (context, state) {
        final cubit = context.read<CreateNoteCubit>();
        final isFavorite = state.isFavorite;
        final isEditMode = cubit.isEditMode;
        final isLoading = state is NoteLoading;

        return AppBar(
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          title: Text(
            isEditMode ? StringConstants.editNote : StringConstants.createNote,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          centerTitle: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 16.w,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            onPressed: () => context.read<CreateNoteCubit>().handleBackPressed(),
          ),
          actions: [
            // Favorite Toggle
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: 20.w,
                color: isFavorite
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              onPressed: () => context.read<CreateNoteCubit>().toggleFavorite(),
            ),
            // Save Button
            Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: TextButton(
                onPressed: isLoading ? null : () => context.read<CreateNoteCubit>().handleSavePressed(),
                child: Text(
                  isLoading ? StringConstants.noteSaving : (isEditMode ? StringConstants.updateNote : StringConstants.saveNote),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isLoading
                        ? colorScheme.onSurface.withValues(alpha: 0.5)
                        : colorScheme.primary,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
