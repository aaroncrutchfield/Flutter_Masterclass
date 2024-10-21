# TODO - Update this variables with your organization name
ORG_NAME := com.apostletec

## ======================= CLI TOOLS ======================== ##
## Very Good CLI		- https://pub.dev/packages/very_good_cli
## FlutterFire CLI		- https://pub.dev/packages/flutterfire_cli
## Mason CLI			- https://pub.dev/packages/mason_cli
## Bloc Feature Brick	- https://brickhub.dev/bricks/flutter_bloc_feature
## ========================================================== ##
install-cli-tools:
	dart pub global activate very_good_cli ; \
	dart pub global activate flutterfire_cli ; \
	dart pub global activate mason_cli ; \
    mason init ; \
    mason add flutter_bloc_feature ;


# Create a new app in the apps directory using very_good_cli app template
# https://cli.vgv.dev/docs/templates/core
# Template features:
# - Build flavors
# - Internationalization support
# - Bloc pattern
# - Very Good Analysis
app:
	echo "Please give your new app a name:" ; \
    read APP_NAME ; \
    APP_NAME=$$(echo "$$APP_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /_/g') ; \
    very_good create flutter_app $$APP_NAME --org-name=$(ORG_NAME) --description="$$APP_NAME"  ;