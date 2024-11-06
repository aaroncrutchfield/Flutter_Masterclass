// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ai_chat_app/app/di/helper/config/firebase_config.dart' as _i745;
import 'package:ai_chat_app/app/di/helper/firebase_module.dart' as _i667;
import 'package:ai_chat_app/app/navigation/app_navigation.dart' as _i737;
import 'package:ai_chat_app/app/navigation/auto_route/auto_router.dart'
    as _i848;
import 'package:ai_chat_app/core/auth/data/auth_remote_data_source.dart'
    as _i116;
import 'package:ai_chat_app/core/auth/domain/auth_repository.dart' as _i334;
import 'package:ai_chat_app/counter/cubit/counter_cubit.dart' as _i480;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as _i8;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

const String _production = 'production';
const String _development = 'development';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i8.FirebaseUIAuth>(() => appModule.firebaseUIAuth);
    gh.singleton<_i59.FirebaseAuth>(() => appModule.firebaseAuth);
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
    gh.singleton<_i116.AuthRemoteDataSource>(
        () => _i116.FirebaseAuthDataSource(gh<_i59.FirebaseAuth>()));
    gh.singleton<_i745.FirebaseConfig>(
      () => _i745.StgFirebaseConfig(),
      registerFor: {_production},
    );
    gh.factory<_i480.CounterCubit>(
        () => _i480.CounterCubit(gh<_i737.AppNavigation>()));
    gh.factory<_i334.AuthRepository>(
        () => _i334.FirebaseAuthRepository(gh<_i116.AuthRemoteDataSource>()));
    return this;
  }
}

class _$AppModule extends _i667.AppModule {}
