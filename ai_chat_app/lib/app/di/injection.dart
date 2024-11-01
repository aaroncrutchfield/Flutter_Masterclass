

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

abstract interface class Registry {
  Future<void> init();

  T get<T extends Object>();

  T call<T extends Object>();

  void reset();
}

abstract class GetItRegistry implements Registry {
  const GetItRegistry(this.getIt);

  @protected
  final GetIt getIt;

  @override
  T get<T extends Object>() => getIt.get<T>();

  @override
  void reset() => getIt.reset();

  @override
  T call<T extends Object>() => getIt.call<T>();
}