// hooks/post_gen.dart
import 'package:flutter_launch_kit_hooks/hooks.dart';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  // final dependencyUtils = DependencyUtils(
  //   context.logger,
  //   Dependency.values,
  //   DevDependency.values,
  // );
  final setupUtils = SetupInstructionsUtils(context.logger);
  final melosUtils = MelosUtils(context.logger);

  try {
    // Install dependencies
    // await dependencyUtils.installDependencies();

    // Run melos bootstrap
    // await melosUtils.bootstrap();

    // Show setup instructions
    setupUtils.showNextSteps();
  } catch (e) {
    context.logger.err(e.toString());
    throw Exception('Post-generation setup failed');
  }
}
