import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/app/environments.dart';
import 'package:{{project_name.snakeCase()}}/bootstrap.dart';

void main() {
  bootstrap(
    environment: Environment.production,
    builder: () => const App(),
  );
}
