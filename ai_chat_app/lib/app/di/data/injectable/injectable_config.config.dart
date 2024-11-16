// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ai_chat_app/app/di/data/injectable/firebase_module.dart'
    as _i22;
import 'package:ai_chat_app/app/navigation/app_navigation.dart' as _i737;
import 'package:ai_chat_app/app/navigation/data/auto_route/auto_router.dart'
    as _i817;
import 'package:ai_chat_app/core/auth/auth_repository.dart' as _i846;
import 'package:ai_chat_app/core/auth/data/auth_remote_data_source.dart'
    as _i116;
import 'package:ai_chat_app/features/auth/cubit/auth_cubit.dart' as _i177;
import 'package:ai_chat_app/features/chat/bloc/chat_bloc.dart' as _i531;
import 'package:ai_chat_app/features/counter/cubit/counter_cubit.dart'
    as _i1053;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as _i8;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

const String _staging = 'staging';
const String _development = 'development';
const String _production = 'production';

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
    gh.factory<_i1053.CounterCubit>(() => _i1053.CounterCubit());
    gh.factory<_i531.ChatBloc>(() => _i531.ChatBloc());
    gh.singleton<_i817.RootAutoRouter>(() => _i817.RootAutoRouter());
    gh.singleton<_i982.FirebaseOptions>(
      () => firebaseModule.getStgOptions(),
      registerFor: {_staging},
    );
    gh.singleton<_i737.AppNavigation>(
        () => _i737.AutoRouteNavigation(gh<_i817.RootAutoRouter>()));
    gh.singleton<_i982.FirebaseOptions>(
      () => firebaseModule.getDevOptions(),
      registerFor: {_development},
    );
    gh.singleton<_i982.FirebaseOptions>(
      () => firebaseModule.getProdOptions(),
      registerFor: {_production},
    );
    await gh.factoryAsync<_i982.FirebaseApp>(
      () => firebaseModule.getFirebase(gh<_i982.FirebaseOptions>()),
      registerFor: {
        _development,
        _staging,
        _production,
      },
      preResolve: true,
    );
    gh.singleton<_i8.FirebaseUIAuth>(
        () => firebaseModule.getFirebaseUIAuth(gh<_i982.FirebaseApp>()));
    gh.singleton<_i59.FirebaseAuth>(
        () => firebaseModule.getFirebaseAuth(gh<_i982.FirebaseApp>()));
    gh.singleton<_i116.AuthRemoteDataSource>(
        () => _i116.FirebaseAuthDataSource(gh<_i59.FirebaseAuth>()));
    gh.singleton<_i846.AuthRepository>(
        () => _i846.FirebaseAuthRepository(gh<_i116.AuthRemoteDataSource>()));
    gh.factory<_i177.AuthCubit>(() => _i177.AuthCubit(
          gh<_i737.AppNavigation>(),
          gh<_i846.AuthRepository>(),
        ));
    return this;
  }
}

class _$FirebaseModule extends _i22.FirebaseModule {}
