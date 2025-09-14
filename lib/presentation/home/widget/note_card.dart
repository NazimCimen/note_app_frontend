import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/core/utils/time_utils.dart';
import 'package:flutter_note_app/domain/entities/note_entity.dart';
import 'package:flutter_note_app/presentation/home/bloc/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({required this.note, super.key});
  final NoteEntity note;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to note detail/edit page
        //  context.push('/note/${note.id}');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            width: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (note.id != null) {
                      context.read<HomeCubit>().toggleNoteFavorite(note.id!);
                    }
                  },
                  child: Icon(
                    note.isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 20.w,
                    color: note.isFavorite
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),

            SizedBox(height: 6.h),

            Text(
              note.content,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 13.sp,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 8.h),

            Text(
              TimeUtils.formatDate(note.updatedAt ?? note.createdAt),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 11.sp,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

