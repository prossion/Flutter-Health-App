import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_health_app/blocs/auth_bloc/auth_state.dart';
import 'package:flutter_health_app/repositories/auth_repository.dart';
import 'package:flutter_health_app/screens/home_page.dart';
import 'package:flutter_health_app/screens/sign_in_screen.dart';
import 'package:flutter_health_app/screens/sign_up_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => FirebaseAuthRepository(),
      child: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          authRepository:
              RepositoryProvider.of<FirebaseAuthRepository>(context),
        ),
        child: MaterialApp(
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is UnAuthState) {
                return const SignInScreen();
              } else {
                return const HomePage();
              }
            },
          ),
        ),
      ),
    );
  }
}
