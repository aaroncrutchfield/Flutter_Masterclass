# Dependency Injection System Guide

## Overview

This project uses a dependency injection (DI) system built with `get_it` and `injectable` to manage application dependencies. The system helps organize services, configurations, and features across different environments while making the codebase more maintainable and testable.

## Project Structure

```
├── config/
│   ├── app_config.dart         # Main application configuration
│   ├── app_config.config.dart  # Generated configuration code
│   ├── test_config.dart        # Test environment configuration
│   ├── test_config.config.dart # Generated test configuration code
│   ├── firebase_config.dart    # Firebase environment configurations
│   └── get_it_config.dart      # Base configuration interface
├── firebase_module.dart        # Firebase service configurations
├── registry_source.dart        # GetIt wrapper implementation
├── injection_registry.dart     # Main registry interface
└── annotations.dart           # Environment constants
```

## Key Components

### 1. Injection Registry

The `injection_registry.dart` file provides two main registries:
- `appRegistry`: Used in the actual application
- `testRegistry`: Used for testing environments

Basic usage:
```dart
// Initialize the application registry
await appRegistry.init(Environment.development);

// Retrieve a service
final authService = appRegistry.get<AuthService>();
// Or using the shorter syntax
final authService = appRegistry<AuthService>();
```

### 2. Configuration System

The configuration system is split into app and test configurations:

#### Application Configuration
```dart
@injectable
class GetItAppConfig implements GetItConfig {
  @override
  Future<void> configureDependencies(
    String environment,
    GetIt getIt,
  ) => _configureAppDependencies(getIt, environment);
}
```

#### Test Configuration
```dart
@injectable
class GetItTestConfig implements GetItConfig {
  @override
  Future<void> configureDependencies(
    String environment,
    GetIt getIt,
  ) => _configureTestDependencies(getIt, environment);
}
```

### 3. Environment Management

The system supports four environments (defined in `annotations.dart`):
```dart
const development = Environment('development');
const staging = Environment('staging');
const production = Environment('production');
const testing = Environment('testing');
```

### 4. Firebase Configuration

Each environment has its own Firebase configuration:

```dart
@development
@Singleton(as: FirebaseConfig)
class DevFirebaseConfig implements FirebaseConfig {
  @override
  FirebaseOptions get options => dev.DefaultFirebaseOptions.currentPlatform;
}

@production
@Singleton(as: FirebaseConfig)
class ProdFirebaseConfig implements FirebaseConfig {
  // Production configuration
}
```

## Common Usage Patterns

### 1. Service Registration

Register services using appropriate annotations:

```dart
// Single instance across the app
@singleton
class AuthenticationService {
  // Implementation
}

// New instance each time
@injectable
class UserRepository {
  // Implementation
}

// Created only when first requested
@lazySingleton
class AnalyticsService {
  // Implementation
}
```

### 2. Environment-Specific Implementation

```dart
// Interface
abstract class DataStorage {
  Future<void> saveData(String key, dynamic value);
}

// Development version
@development
@Singleton(as: DataStorage)
class LocalDataStorage implements DataStorage {
  // Local storage implementation
}

// Production version
@production
@Singleton(as: DataStorage)
class CloudDataStorage implements DataStorage {
  // Cloud storage implementation
}
```

### 3. Testing Setup

```dart
void main() {
  setUp(() async {
    await testRegistry.init(Environment.test);
  });

  tearDown(() {
    testRegistry.reset();
  });

  test('authentication flow', () {
    final auth = testRegistry.get<AuthenticationService>();
    // Test implementation
  });
}
```

## Best Practices

1. **Service Registration**
    - Use `@singleton` for services that should be shared across the app
    - Use `@injectable` for services that need fresh instances
    - Use `@lazySingleton` for heavy services that aren't needed immediately

2. **Code Generation**
   After modifying injectable dependencies, regenerate the configuration:
   ```bash
   dart run build_runner build
   ```

3. **Dependency Resolution**
    - Avoid circular dependencies
    - Keep service responsibilities focused and clear
    - Use factories for complex object creation

4. **Testing**
    - Always use `testRegistry` in tests
    - Reset the registry in tearDown
    - Mock dependencies when needed for isolated testing

## Common Issues and Solutions

1. **Dependency Not Found**
    - Ensure the service is properly annotated
    - Check that code generation has run
    - Verify the environment annotation matches your current environment

## Additional Resources

- [get_it Package Documentation](https://pub.dev/packages/get_it)
- [injectable Package Documentation](https://pub.dev/packages/injectable)
- Project source code documentation in individual files

## EXTRA: Example of Switching DI Systems (GetIt)

GetX can be used as an alternative to get_it while maintaining the same architecture. Here's a short
example of how to switch to GetX while keeping the existing DI system intact.

### 1. Create GetX Registry Source

```dart
import 'package:get/get.dart';
import 'package:your_app/app/environments.dart';

class GetXRegistrySource {
  const GetXRegistrySource(this._firebaseModule);

  final FirebaseModule _firebaseModule = FirebaseModule();

  Future<void> init(Environment environment) async {
    // We still use the existing config for setup organization
     final firebaseConfig = switch(environment) {
        Environment.development => DevFirebaseConfig(),
        Environment.staging => StgFirebaseConfig(),
        Environment.production => ProdFirebaseConfig(),
        Environment.testing => null,
     };
     
     if (firebaseConfig != null) {
        // Get Firebase app based on the environment 
        final firebaseApp = await _firebaseModule.getFirebaseApp(firebaseConfig);
        // Apply the app to other Firebase services
        Get.put(() => _firebaseModule.getFirebaseUIAuth(firebaseApp));
        Get.put(() => _firebaseModule.getFirebaseAuth(firebaseApp));
     }
     
     // Register other services...
  }

  T get<T extends Object>() {
    try {
      return Get.find<T>();
    } catch (e) {
      throw Exception('Dependency $T not found');
    }
  }

  void reset() {
    Get.reset();
  }

  T call<T extends Object>() => get<T>();

  void register<T extends Object>(T Function() factoryFunction) {
    Get.put<T>(factoryFunction);
  }
}
```

### 2. Create GetX Implementation of InjectionRegistry

```dart
class GetXInjectionRegistry implements InjectionRegistry {
  const GetXInjectionRegistry(this.registrySource);

  final GetXRegistrySource registrySource;

  @override
  Future<void> init(Environment environment) => registrySource.init(
        environment,
      );

  @override
  T get<T extends Object>() => registrySource.get<T>();

  @override
  void reset() => registrySource.reset();

  @override
  T call<T extends Object>() => registrySource.call<T>();

  @override
  void register<T extends Object>(T Function() factoryFunction) {
    registrySource.register(factoryFunction);
  }
}
```

### 3. Usage Example

```dart
// Create a new registry instance using GetX
final InjectionRegistry appRegistry = GetXInjectionRegistry(
  GetXRegistrySource(GetItAppConfig()),
);

// Use it the same way as the get_it implementation
void main() async {
  // Initialize as before
  await appRegistry.init(Environment.development);
  
  // Get dependencies as before
  final authService = getXRegistry.get<AuthService>();
  
  runApp(MyApp());
}
```

### 4. Key Differences with GetX

- All dependencies must be registered manually instead of using annotations
- GetX uses `Get.put()` for immediate initialization (similar to registerSingleton)
- `Get.find()` for retrieving instances (similar to get_it's get)
- `Get.reset()` for clearing all dependencies

## Advantages of our Abstracted Dependency Injection System

1. Maintains existing architecture and interface
2. Allows easy switching between DI solutions
3. Preserves environment configuration system
4. Keeps the same usage pattern in the application code

Remember that while GetX offers many other features (state management, navigation, etc.), this implementation focuses solely on its dependency injection capabilities to maintain consistency with the existing architecture.