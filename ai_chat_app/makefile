# Firebase CLI Variables
# TODO - Update these variables with your Firebase project details
FIREBASE_PROJECT_ID := apostletec-ai-chat-app
# Uses underscores in place of spaces
ANDROID_PACKAGE_NAME := com.apostletec.ai_chat_app
# Uses hyphens in place of spaces
IOS_BUNDLE_ID := com.apostletec.ai-chat-app


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