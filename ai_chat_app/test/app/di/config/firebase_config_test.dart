import 'package:ai_chat_app/app/di/helper/config/firebase_config.dart';
import 'package:ai_chat_app/firebase/firebase_options_dev.dart' as dev;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirebaseConfig', () {
    late FirebaseConfig devConfig;
    late FirebaseConfig stgConfig;
    late FirebaseConfig prodConfig;

    setUp(() {
      devConfig = DevFirebaseConfig();
      stgConfig = StgFirebaseConfig();
      prodConfig = ProdFirebaseConfig();
    });

    test('DevFirebaseConfig returns development FirebaseOptions', () {
      expect(devConfig.options, dev.DefaultFirebaseOptions.currentPlatform);
    });

    test('StgFirebaseConfig throws UnimplementedError', () {
      expect(() => stgConfig.options, throwsUnimplementedError);
    });

    test('ProdFirebaseConfig throws UnimplementedError', () {
      expect(() => prodConfig.options, throwsUnimplementedError);
    });
  });
}
