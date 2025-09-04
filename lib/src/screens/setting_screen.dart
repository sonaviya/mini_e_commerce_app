import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/setting/setting_bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsCubit>().state;

    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text("Dark Mode"),
            value: settings.themeMode == ThemeMode.dark,
            onChanged: (_) => context.read<SettingsCubit>().toggleTheme(),
          ),
          ListTile(
            title: Text("Language"),
            subtitle: Text(
              settings.locale.languageCode == "en" ? "English" : "Español",
            ),
            trailing: DropdownButton<Locale>(
              value: settings.locale,
              items: const [
                DropdownMenuItem(value: Locale('en'), child: Text("English")),
                DropdownMenuItem(value: Locale('es'), child: Text("Español")),
              ],
              onChanged: (locale) {
                if (locale != null) {
                  context.read<SettingsCubit>().changeLanguage(locale);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
