import 'package:flutter_launch_kit_app/hooks.dart';
import 'package:test/test.dart';

void main() {
  group('$VeryGoodCoreConfiguration', () {
    group('defaults', () {
      test('project_name to "my_app"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.projectName, 'my_app');
      });

      test('organization_name to "com.example"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.organizationName, 'com.example');
      });

      test('description to "A Flutter Launch Kit App"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.description, 'A Flutter Launch Kit App');
      });

      test('windowsApplicationId to "com.example.my-app"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.windowsApplicationId.value, 'com.example.my-app');
      });

      test('iOsApplicationId to "com.example.my-app"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.iOsApplicationId.value, 'com.example.my-app');
      });

      test('macOsApplicationId to "com.example.my-app"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.macOsApplicationId.value, 'com.example.my-app');
      });

      test('androidApplicationId to "com.example.my_app"', () {
        final configuration = VeryGoodCoreConfiguration();
        expect(configuration.androidApplicationId.value, 'com.example.my_app');
      });
    });

    group('throws', () {
      group('a $InvalidAndroidApplicationIdFormat when Android ID', () {
        test('has special characters', () {
          expect(
            () => VeryGoodCoreConfiguration(
              androidApplicationId: AndroidApplicationId('com.example.my_app!'),
            ),
            throwsA(isA<InvalidAndroidApplicationIdFormat>()),
          );
        });

        test('parts start with numeric character', () {
          expect(
            () => VeryGoodCoreConfiguration(
              androidApplicationId:
                  AndroidApplicationId('1com.1example.1my_app'),
            ),
            throwsA(isA<InvalidAndroidApplicationIdFormat>()),
          );
        });

        test('has a single part', () {
          expect(
            () => VeryGoodCoreConfiguration(
              androidApplicationId: AndroidApplicationId('com'),
            ),
            throwsA(isA<InvalidAndroidApplicationIdFormat>()),
          );
        });
      });
    });

    group('fromHookVars', () {
      test('decodes as expected', () {
        final vars = {
          'project_name': 'flutter launch kit app',
          'org_name': 'com.flkit',
          'application_id': 'com.flkit.flutter_launch_kit_app',
          'description': 'A Flutter Launch Kit App',
        };

        final configuration = VeryGoodCoreConfiguration.fromHookVars(vars);
        expect(
          configuration,
          equals(
            VeryGoodCoreConfiguration(
              projectName: 'flutter launch kit app',
              organizationName: 'com.flkit',
              description: 'A Flutter Launch Kit App',
              windowsApplicationId:
                  WindowsApplicationId('com.flkit.flutter_launch_kit_app'),
              iOsApplicationId:
                  AppleApplicationId('com.flkit.flutter_launch_kit_app'),
              macOsApplicationId:
                  AppleApplicationId('com.flkit.flutter_launch_kit_app'),
              androidApplicationId:
                  AndroidApplicationId('com.flkit.flutter_launch_kit_app'),
              androidNamespace:
                  AndroidNamespace('com.flkit.flutter_launch_kit_app'),
            ),
          ),
        );
      });

      test('defaults id when empty', () {
        final vars = {
          'project_name': 'flutter launch kit app',
          'org_name': 'com.flkit',
          'application_id': '',
          'description': 'A Flutter Launch Kit App',
        };

        final configuration = VeryGoodCoreConfiguration.fromHookVars(vars);
        expect(
          configuration,
          equals(
            VeryGoodCoreConfiguration(
              projectName: 'flutter launch kit app',
              organizationName: 'com.flkit',
              description: 'A Flutter Launch Kit App',
              windowsApplicationId:
                  WindowsApplicationId('com.flkit.flutter-launch-kit-app'),
              iOsApplicationId:
                  AppleApplicationId('com.flkit.flutter-launch-kit-app'),
              macOsApplicationId:
                  AppleApplicationId('com.flkit.flutter-launch-kit-app'),
              androidApplicationId:
                  AndroidApplicationId('com.flkit.flutter_launch_kit_app'),
              androidNamespace:
                  AndroidNamespace('com.flkit.flutter_launch_kit_app'),
            ),
          ),
        );
      });

      group('throws $ArgumentError', () {
        test('when "project_name" is not a String?', () {
          final vars = <String, dynamic>{'project_name': 42};

          expect(
            () => VeryGoodCoreConfiguration.fromHookVars(vars),
            throwsA(
              isA<ArgumentError>().having(
                (error) => error.message,
                'message',
                '''Expected a value for key "project_name" to be of type String?, got 42.''',
              ),
            ),
          );
        });

        test('when "org_name" is not a String?', () {
          final vars = <String, dynamic>{'org_name': 42};

          expect(
            () => VeryGoodCoreConfiguration.fromHookVars(vars),
            throwsA(
              isA<ArgumentError>().having(
                (error) => error.message,
                'message',
                '''Expected a value for key "org_name" to be of type String?, got 42.''',
              ),
            ),
          );
        });

        test('when "application_id" is not a String?', () {
          final vars = <String, dynamic>{'application_id': 42};

          expect(
            () => VeryGoodCoreConfiguration.fromHookVars(vars),
            throwsA(
              isA<ArgumentError>().having(
                (error) => error.message,
                'message',
                '''Expected a value for key "application_id" to be of type String?, got 42.''',
              ),
            ),
          );
        });

        test('when "description" is not a String?', () {
          final vars = <String, dynamic>{'description': 42};

          expect(
            () => VeryGoodCoreConfiguration.fromHookVars(vars),
            throwsA(
              isA<ArgumentError>().having(
                (error) => error.message,
                'message',
                '''Expected a value for key "description" to be of type String?, got 42.''',
              ),
            ),
          );
        });
      });
    });
  });
}
