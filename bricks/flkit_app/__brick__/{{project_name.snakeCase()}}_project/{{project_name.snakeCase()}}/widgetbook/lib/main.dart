import 'package:{{project_name.snakeCase()}}/app/di/injection_registry.dart';
import 'package:{{project_name.snakeCase()}}/app/environments.dart';
import 'package:{{project_name.snakeCase()}}/l10n/arb/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

Future<void> main() async {
  await appRegistry.init(Environment.development);
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // The [directories] variable does not exist yet,
      // it will be generated in the next step
      directories: directories,
      addons: [
        // This must come first or the device frame will not respect the theme
        DeviceFrameAddon(
          initialDevice: Devices.ios.iPhone13ProMax,
          devices: [
            Devices.ios.iPhoneSE,
            Devices.ios.iPhone13ProMax,
            Devices.ios.iPadPro11Inches,
            Devices.macOS.macBookPro,
            Devices.android.smallPhone,
            Devices.android.bigPhone,
            Devices.android.mediumTablet,
          ],
        ),
        InspectorAddon(),
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Dark',
              data: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: Colors.blue,
                ),
                useMaterial3: true,
              ),
            ),
            WidgetbookTheme(
              name: 'Light',
              data: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.light,
                  seedColor: Colors.blue,
                ),
                useMaterial3: true,
              ),
            ),
          ],
        ),
        TextScaleAddon(),
        AlignmentAddon(),
        LocalizationAddon(
          initialLocale: const Locale('en'),
          locales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
      ],
    );
  }
}
