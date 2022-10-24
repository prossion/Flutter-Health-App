import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_health_app/repositories/auth_repository.dart';
import 'package:flutter_health_app/screens/home_page.dart';
import 'package:flutter_health_app/screens/sign_in_screen.dart';
import 'package:flutter_health_app/screens/sign_up_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authRepository: RepositoryProvider.of<FirebaseAuthRepository>(context),
      ),
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
    );
  }
}
