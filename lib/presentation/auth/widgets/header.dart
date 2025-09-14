import 'package:flutter/material.dart';
import 'package:flutter_note_app/core/config/localization/string_constants.dart';

/// Auth header widget for displaying title and subtitle
class Header extends StatelessWidget {
  final String title;
  final String subtitle;
  const Header({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title.isEmpty ? StringConstants.welcomeTitle : title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            height: 2,
          ),
        ),
        Text(
          subtitle.isEmpty ? StringConstants.welcomeSubtitle : subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withValues(alpha: 0.9),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
