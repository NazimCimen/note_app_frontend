import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/utils/size/app_border_radius_extensions.dart';
import 'package:flutter_note_app/core/utils/size/constant_size.dart';

class AddItemActionButtons extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onAdd;
  final bool isLoading;
  
  const AddItemActionButtons({
    super.key, 
    this.onCancel, 
    this.onAdd,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: isLoading ? null : onCancel,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: context.cMediumValue),
              side: BorderSide(color: colorScheme.outline),
              shape: RoundedRectangleBorder(
                borderRadius: context.cBorderRadiusAllMedium,
              ),
            ),
            child: Text(
              'İptal',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        SizedBox(width: context.cMediumValue),
        Expanded(
          child: ElevatedButton(
            onPressed: isLoading ? null : onAdd,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              padding: EdgeInsets.symmetric(vertical: context.cMediumValue),
              shape: RoundedRectangleBorder(
                borderRadius: context.cBorderRadiusAllMedium,
              ),
            ),
            child: isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
                    ),
                  )
                : Text(
                    'Ekle',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
