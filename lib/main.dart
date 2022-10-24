import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_health/blocs/get_achievements/get_achievements_bloc.dart';
import 'package:flutter_health/blocs/get_achievements/get_achievements_event.dart';
import 'package:flutter_health/blocs/health_bloc/health_bloc.dart';
import 'package:flutter_health/blocs/simple_bloc_obserever.dart';
import 'package:flutter_health/repositories/auth_repository.dart';
import 'package:flutter_health/repositories/database_repository.dart';
import 'package:flutter_health/repositories/health_repository.dart';
import 'package:flutter_health/screens/home_page.dart';
import 'package:flutter_health/screens/sign_in_screen.dart';
import 'package:flutter_health/services/firebase_service.dart';
import 'package:flutter_health/services/health_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final healthRepository = HealthRepository(services: HealthServices());
  final getAchievementsRepository =
      DatabaseRepository(services: FirebaseService());
  runZonedGuarded<void>(
    () {
      Bloc.observer = SimpleBlocObserver();
      runApp(MyApp(
        healthRepository: healthRepository,
        databaseRepository: getAchievementsRepository,
      ));
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

class MyApp extends StatelessWidget {
  final HealthRepository healthRepository;
  final DatabaseRepository databaseRepository;
  const MyApp(
      {super.key,
      required this.healthRepository,
      required this.databaseRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => FirebaseAuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository:
                  RepositoryProvider.of<FirebaseAuthRepository>(context),
            ),
          ),
          BlocProvider<HealthBloc>(
            create: (context) => HealthBloc(healthRepository: healthRepository),
          ),
          BlocProvider<GetAchievementsBloc>(
            create: (context) =>
                GetAchievementsBloc(databaseRepository: databaseRepository)
                  ..add(GetAchievementsDataEvent()),
          ),
        ],
        child: MaterialApp(
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const HomePage();
              } else {
                return const SignInScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
