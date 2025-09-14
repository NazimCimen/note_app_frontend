import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/utils/size/constant_size.dart';

class CustomLoadingContainer extends StatelessWidget {
  const CustomLoadingContainer({
    required this.colorScheme,
    required this.textTheme,
    required this.text,
    super.key,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(context.cLargeValue),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(context.cMediumValue),
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              ),
              SizedBox(height: context.cMediumValue),
              Text(
                text,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}