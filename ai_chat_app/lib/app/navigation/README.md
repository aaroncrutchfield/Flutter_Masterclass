# Navigation System Documentation

## Overview
This project implements a flexible navigation system using AutoRoute for Flutter applications. The system consists of two main components:
- `AppNavigation`: An abstract interface defining core navigation operations
- `AutoRouteNavigation`: The concrete implementation using AutoRoute

## Setup

1. Configure routes in `RootAutoRouter`:
```dart
@AutoRouterConfig()
class RootAutoRouter extends RootStackRouter {
  List<AutoRoute> get routes => [
    AutoRoute(path: '/login', page: AuthRoute.page, initial: true),
    AutoRoute(path: '/counter', page: CounterRoute.page),
  ];
}
```

2. Initialize navigation in your app:
```dart
MaterialApp.router(
  routerConfig: appNavigation.routerConfig(),
)
```

## Usage

### Basic Navigation
```dart
// Navigate to a named route
await appNavigation.navigateNamed('/login');

// Push a new route
await appNavigation.pushNamed('/counter');

// Replace current route
appNavigation.replaceNamed('/login');

// Pop current route
await appNavigation.maybePop();
```

## Features
- Platform-adaptive route transitions
- Type-safe route generation
- Dependency injection ready with `@injectable`
- Clean architecture with interface-based design

## Best Practices
1. Always use the `AppNavigation` interface instead of concrete implementation
2. Define routes in `RootAutoRouter` using path constants
3. Handle navigation failures appropriately by awaiting Future results