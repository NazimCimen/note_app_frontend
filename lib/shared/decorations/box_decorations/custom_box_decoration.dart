import 'package:flutter_note_app/core/utils/size/constant_size.dart';
import 'package:flutter_note_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/utils/size/app_border_radius_extensions.dart';

class CustomBoxDecoration {
  CustomBoxDecoration._();
  static BoxDecoration customBoxDecorationForImage(BuildContext context) {
    return BoxDecoration(
      borderRadius: context.borderRadiusAllLow,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      border: Border.all(
        color: Theme.of(context).colorScheme.tertiary,
        width: 2,
      ),
    );
  }

  static BoxDecoration customBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: context.borderRadiusAllLow,
    );
  }

  static BoxDecoration customBoxDecorationTopRadius(BuildContext context) {
    return BoxDecoration(
      //  color: AppColors.background,
      border: const Border(top: BorderSide(color: AppColors.grey)),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(context.cMediumValue),
        topRight: Radius.circular(context.cMediumValue),
      ),
    );
  }

  static BoxDecoration customInputSheetDecoration(BuildContext context) {
    return BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(context.cLargeValue),
              topRight: Radius.circular(context.cLargeValue),
            ),
          );
  }
}
