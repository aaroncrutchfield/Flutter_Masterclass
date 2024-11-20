import 'package:mason/mason.dart';

class SetupInstructionsUtils {
  const SetupInstructionsUtils(this._logger);

  final Logger _logger;

  /// Display next steps and setup instructions
  void showNextSteps() {
    _logger.success('''
  
✓ Dependencies installed
✓ Dependency injection files generated
✓ Injectable config files generated with build_runner
  
Next steps:
1. Check the generated files in lib/app/di/
2. Add your dependencies to the appropriate config files
3. Set up your Firebase configuration in firebase_options_dev.dart
4. Run build_runner again if you make changes to @injectable classes

Note: If you haven't set up Firebase yet, you'll need to:
1. Install the Firebase CLI
2. Run 'flutterfire configure'
3. Follow the Firebase setup instructions
''');
  }
}
