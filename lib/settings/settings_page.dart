import 'package:draft/settings/widgets/app_text.dart';
import 'package:draft/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: theme.textTheme.headlineLarge?.copyWith(
            color: theme.appBarTheme.titleTextStyle?.color,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: theme.dividerColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              title: LocaleKeys.routes_notifications.tr(),
              children: [
                SettingsSwitchCard(
                  title: LocaleKeys.general_get_email.tr(),
                  subtitle: 'Получать уведомления по электронной почте',
                  value: true,
                  onChanged: (value) {},
                ),
                SettingsSwitchCard(
                  title: LocaleKeys.general_get_sms.tr(),
                  subtitle: 'SMS уведомления о заказах',
                  value: true,
                  onChanged: (value) {},
                ),
                SettingsSwitchCard(
                  title: LocaleKeys.general_get_push_notifications.tr(),
                  subtitle: 'Push уведомления в приложении',
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),

            _buildSection(
              context,
              title: 'Конфиденциальность',
              children: [
                SettingsNavigateCard(
                  title: 'Изменить PIN-код',
                  subtitle: 'Обновить код доступа к приложению',
                  icon: Icons.lock_outline,
                  onTap: () {},
                ),
                SettingsNavigateCard(
                  title: 'Биометрическая аутентификация',
                  subtitle: 'Вход по отпечатку пальца или Face ID',
                  icon: Icons.fingerprint,
                  onTap: () {},
                ),
                SettingsSwitchCard(
                  title: 'Двухфакторная аутентификация',
                  subtitle: 'Дополнительная защита аккаунта',
                  value: false,
                  onChanged: (value) {},
                ),
              ],
            ),

            _buildSection(
              context,
              title: 'Приложение',
              children: [
                SettingsNavigateCard(
                  title: 'Язык',
                  subtitle: 'Русский',
                  icon: Icons.language,
                  onTap: () {},
                ),
                SettingsNavigateCard(
                  title: 'Тема оформления',
                  subtitle: 'Системная',
                  icon: Icons.palette_outlined,
                  onTap: () {},
                ),
                SettingsSwitchCard(
                  title: 'Автоматические обновления',
                  subtitle: 'Загружать обновления в фоне',
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),

            _buildSection(
              context,
              title: 'Поддержка',
              children: [
                SettingsNavigateCard(
                  title: 'Помощь и поддержка',
                  subtitle: 'Часто задаваемые вопросы',
                  icon: Icons.help_outline,
                  onTap: () {},
                ),
                SettingsNavigateCard(
                  title: 'Связаться с нами',
                  subtitle: 'Напишите нам, если есть вопросы',
                  icon: Icons.contact_support_outlined,
                  onTap: () {},
                ),
                SettingsNavigateCard(
                  title: 'О приложении',
                  subtitle: 'Версия 1.0.0',
                  icon: Icons.info_outline,
                  onTap: () {},
                ),
              ],
            ),

            _buildSection(
              context,
              title: LocaleKeys.general_account.tr(),
              children: [
                SettingsNavigateCard(
                  title: 'Мои данные',
                  subtitle: 'Управление личной информацией',
                  icon: Icons.person_outline,
                  onTap: () {},
                ),
                SettingsNavigateCard(
                  title: 'Адреса доставки',
                  subtitle: 'Сохраненные адреса',
                  icon: Icons.location_on_outlined,
                  onTap: () {},
                ),
                SettingsNavigateCard(
                  title: LocaleKeys.buttons_logout.tr(),
                  subtitle: 'Выйти из аккаунта',
                  icon: Icons.logout,
                  onTap: () {},
                ),
              ],
            ),

            _buildSection(
              context,
              title: 'Опасная зона',
              isDestructive: true,
              children: [
                SettingsNavigateCard(
                  title: LocaleKeys.buttons_delete_account.tr(),
                  subtitle: 'Это действие нельзя отменить',
                  titleColor: Colors.red,
                  icon: Icons.delete_outline,
                  iconColor: Colors.red,
                  onTap: () => _showDeleteAccountDialog(context),
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
    bool isDestructive = false,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: AppText(
              title: title,
              textType: TextType.title20,
              fontWeight: FontWeight.w600,
              color: isDestructive ? Colors.red : null,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: theme.appBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children:
                  children.asMap().entries.map((entry) {
                    final index = entry.key;
                    final child = entry.value;
                    final isLast = index == children.length - 1;

                    return Column(
                      children: [
                        child,
                        if (!isLast)
                          Divider(
                            height: 1,
                            thickness: 0.5,
                            color: theme.dividerColor.withOpacity(0.3),
                            indent: 16,
                            endIndent: 16,
                          ),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Удалить аккаунт?'),
            content: const Text(
              'Это действие удалит ваш аккаунт и все связанные данные безвозвратно. Вы уверены?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Handle account deletion
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Удалить'),
              ),
            ],
          ),
    );
  }
}
