# Firebase CLI Variables
# TODO - Update these variables with your Firebase project details
FIREBASE_PROJECT_ID := apostletec-ai-chat-app
# Uses underscores in place of spaces
ANDROID_PACKAGE_NAME := com.apostletec.ai_chat_app
# Uses hyphens in place of spaces
IOS_BUNDLE_ID := com.apostletec.ai-chat-app

cubit-feature:
	echo "Please give your new cubit a name:" ; \
	read CUBIT_NAME ; \
	mason make flutter_bloc_feature --name $$CUBIT_NAME --type cubit --style equatable --output-dir=lib/features ;

bloc-feature:
	echo "Please give your new bloc a name:" ; \
	read BLOC_NAME ; \
	mason make flutter_bloc_feature --name $$BLOC_NAME --type bloc --style equatable --output-dir=lib/features ;

test-coverage:
	flutter test --coverage && \
	genhtml coverage/lcov.info -o coverage/html && \
	open coverage/html/index.html ;

build-runner:
	dart run build_runner build --delete-conflicting-outputs

# Quickly fix all formatting issues
quickfix:
	dart fix --apply ; \
	dart format lib test ; \
	dart format --line-length 80 lib test ; \
	flutter analyze lib test ;

## ------- Configure Firebase ------- ##
# https://firebase.google.com/docs/flutter/setup?platform=android#configure-firebase
# https://github.com/invertase/flutterfire_cli/issues/14
# https://codewithandrea.com/articles/flutter-flavors-for-firebase-apps/
# https://firebase.google.com/docs/projects/dev-workflows/general-best-practices#registering-app-variants
firebase-create-development:
	firebase login ; \
	firebase projects:create $(FIREBASE_PROJECT_ID)-dev ;

flutterfire-config-development:
	flutterfire configure \
	  --yes \
	  --project=$(FIREBASE_PROJECT_ID)-dev \
	  --android-package-name=$(ANDROID_PACKAGE_NAME).dev \
	  --android-out=android/app/src/development/google-services.json \
	  --ios-build-config=development \
	  --ios-bundle-id=$(IOS_BUNDLE_ID).dev \
	  --ios-out=ios/development/GoogleService-Info.plist \
	  --macos-build-config=development \
	  --macos-out=macos/development/GoogleService-Info.plist \
	  --macos-bundle-id=$(IOS_BUNDLE_ID).dev \
	  --out=lib/firebase/firebase_options_dev.dart ;