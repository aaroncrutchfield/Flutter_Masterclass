import 'package:ai_chat_app/app/app.dart';
import 'package:ai_chat_app/app/environments.dart';
import 'package:ai_chat_app/bootstrap.dart';

void main() {
  bootstrap(
    environment: Environment.development,
    builder: () => const App(),
  );
}
