import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cài đặt')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark mode'),
            value: themeMode == ThemeMode.dark,
            onChanged: (value) => ref.read(themeModeProvider.notifier).state = value ? ThemeMode.dark : ThemeMode.light,
          ),
          ListTile(
            title: const Text('Nhắc học hằng ngày'),
            subtitle: const Text('Đã sẵn sàng tích hợp local notifications'),
            onTap: () => ref.read(notificationActionProvider).scheduleReminder(),
          ),
          ListTile(
            title: const Text('Google AdMob'),
            subtitle: const Text('Đã sẵn sàng khởi tạo SDK quảng cáo'),
            onTap: () => ref.read(adsActionProvider).initialize(),
          ),
        ],
      ),
    );
  }
}
