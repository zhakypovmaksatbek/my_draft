import 'package:draft/settings/widgets/app_text.dart';
import 'package:flutter/material.dart';

class SettingsSwitchCard extends StatelessWidget {
  const SettingsSwitchCard({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.icon,
    this.iconColor,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final Function(bool) onChanged;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SwitchListTile.adaptive(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      value: value,
      onChanged: onChanged,
      secondary:
          icon != null
              ? Icon(icon, color: iconColor ?? theme.iconTheme.color, size: 24)
              : null,
      title: AppText(
        title: title,
        textType: TextType.body,
        fontWeight: FontWeight.w500,
      ),
      subtitle:
          subtitle != null
              ? AppText(
                title: subtitle!,
                textType: TextType.description,
                color: theme.textTheme.bodySmall?.color,
              )
              : null,
      activeColor: theme.primaryColor,
    );
  }
}

class SettingsNavigateCard extends StatelessWidget {
  const SettingsNavigateCard({
    super.key,
    required this.title,
    required this.onTap,
    this.titleColor,
    this.subtitle,
    this.icon,
    this.iconColor,
  });

  final String title;
  final String? subtitle;
  final Color? titleColor;
  final VoidCallback onTap;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: onTap,
      leading:
          icon != null
              ? Icon(icon, color: iconColor ?? theme.iconTheme.color, size: 24)
              : null,
      title: AppText(
        title: title,
        textType: TextType.body,
        color: titleColor,
        fontWeight: FontWeight.w500,
      ),
      subtitle:
          subtitle != null
              ? AppText(
                title: subtitle!,
                textType: TextType.description,
                color: theme.textTheme.bodySmall?.color,
              )
              : null,
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: theme.disabledColor,
        size: 16,
      ),
    );
  }
}
