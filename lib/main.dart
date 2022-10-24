import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_health_app/blocs/auth_bloc/auth_state.dart';
import 'package:flutter_health_app/blocs/health_bloc/health_bloc.dart';
import 'package:flutter_health_app/repositories/auth_repository.dart';
import 'package:flutter_health_app/repositories/health_repository.dart';
import 'package:flutter_health_app/screens/home_page.dart';
import 'package:flutter_health_app/screens/sign_in_screen.dart';
import 'package:flutter_health_app/services/health_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final healthRepository = HealthRepository(services: HealthServices());
  runApp(MyApp(
    healthRepository: healthRepository,
  ));
}

class MyApp extends StatelessWidget {
  final HealthRepository healthRepository;
  const MyApp({super.key, required this.healthRepository});

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
