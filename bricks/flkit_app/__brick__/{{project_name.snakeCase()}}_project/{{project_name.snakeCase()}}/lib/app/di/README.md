# Dependency Injection Guide

## Overview
This project uses GetIt for dependency injection (DI) with injectable-generator for code generation. The DI system supports multiple environments (development, staging, production) and provides a clean interface for dependency registration and resolution.

## Setup

1. Add dependencies to `pubspec.yaml`:
```yaml
dependencies:
  get_it: ^[version]
  injectable: ^[version]

dev_dependencies:
  injectable_generator: ^[version]
  build_runner: ^[version]
```

2. Configure the DI container using the global registry:
```dart
void main() {
   bootstrap(
      environment: Environment.development,
      builder: () => const App(),
   );
}
```

## Registering Dependencies

### Using Injectable Annotations

```dart
@injectable
class AuthRepository {
  AuthRepository(this._dataSource);
  final AuthRemoteDataSource _dataSource;
}

// For singletons
@singleton
class AppNavigation {
  // ...
}

// Environment-specific registration
@development
@singleton
class DevConfig implements Config {
  // ...
}
```

### Using Modules

Create a module for related dependencies:

```dart
@module
abstract class FirebaseModule {
  @development
  @singleton
  FirebaseOptions getDevOptions() => DevFirebaseOptions.currentPlatform;
  
  @singleton
  FirebaseAuth getFirebaseAuth(FirebaseApp app) => 
      FirebaseAuth.instanceFor(app: app);
}
```

## Using Dependencies

### Regular Injection

```dart
final authRepo = appRegistry.get<AuthRepository>();
// or using call syntax
final authRepo = appRegistry<AuthRepository>();
```

### Factory with Parameters

```dart
final instance = appRegistry.get<MyClass>(
  param1: value1,
  param2: value2,
);
```

## Testing

Use `register()` to mock dependencies in tests:

```dart
void main() {
  setUp(() {
    appRegistry.register<AuthRepository>(() => MockAuthRepository());
  });

  tearDown(() {
    appRegistry.reset();
  });
}
```

## Code Generation

Run the following command after modifying injectable annotations:

```bash
dart run build_runner build
```

## Environment Configuration

Available environments:
- `development`
- `staging`
- `production`

Define environment-specific dependencies using the corresponding annotations:
```dart
@development
@singleton
class DevConfig // ...

@production
@singleton
class ProdConfig // ...
```