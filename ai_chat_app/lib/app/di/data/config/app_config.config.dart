// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ai_chat_app/app/di/data/config/firebase_config.dart' as _i745;
import 'package:ai_chat_app/app/di/data/firebase_module.dart' as _i667;
import 'package:ai_chat_app/app/navigation/app_navigation.dart' as _i737;
import 'package:ai_chat_app/app/navigation/auto_route/auto_router.dart'
    as _i848;
import 'package:ai_chat_app/counter/cubit/counter_cubit.dart' as _i480;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as _i8;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

const String _production = 'production';
const String _development = 'development';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseModule = _$FirebaseModule();
    gh.factory<_i480.CounterCubit>(() => _i480.CounterCubit());
    gh.singleton<_i848.RootAutoRouter>(() => _i848.RootAutoRouter());
    gh.singleton<_i745.FirebaseConfig>(
      () => _i745.ProdFirebaseConfig(),
      registerFor: {_production},
    );
    gh.singleton<_i745.FirebaseConfig>(
      () => _i745.DevFirebaseConfig(),
      registerFor: {_development},
    );
    gh.singleton<_i737.AppNavigation>(
        () => _i737.AutoRouteNavigation(gh<_i848.RootAutoRouter>()));
    gh.singleton<_i745.FirebaseConfig>(
      () => _i745.StgFirebaseConfig(),
      registerFor: {_production},
    );
    await gh.factoryAsync<_i982.FirebaseApp>(
      () => firebaseModule.getFirebase(gh<_i745.FirebaseConfig>()),
      preResolve: true,
    );
    gh.singleton<_i8.FirebaseUIAuth>(
        () => firebaseModule.getFirebaseUIAuth(gh<_i982.FirebaseApp>()));
    gh.singleton<_i59.FirebaseAuth>(
        () => firebaseModule.getFirebaseAuth(gh<_i982.FirebaseApp>()));
    return this;
  }
}

class _$FirebaseModule extends _i667.FirebaseModule {}
