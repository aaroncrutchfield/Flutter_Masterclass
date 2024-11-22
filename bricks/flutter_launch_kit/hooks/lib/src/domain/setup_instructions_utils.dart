import 'package:mason/mason.dart';

class SetupInstructionsUtils {
  const SetupInstructionsUtils(this._logger);

  final Logger _logger;

  /// Display next steps and setup instructions
  void showNextSteps() {
    _logger.success('''
🚀 Launch complete! 🚀

Features:
✓ Dependency injection 
✓ Navigation 2.0
✓ Bloc State Management
✓ Edge-to-Edge Design
✓ Internationalization
✓ Build Flavors
✓ Widgetbook

Next steps:
1. Open the project in Android Studio
2. Run `melos bootstrap` to initialize the project
3. You're all set! 🎉

''');
  }
}
