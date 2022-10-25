import 'package:achievement_view/achievement_view.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_health/blocs/auth_bloc/auth_event.dart';
import 'package:flutter_health/blocs/auth_bloc/auth_state.dart';
import 'package:flutter_health/blocs/get_achievements/get_achievements_bloc.dart';
import 'package:flutter_health/blocs/get_achievements/get_achievements_event.dart';
import 'package:flutter_health/models/achievement_model.dart';
import 'package:flutter_health/screens/home_page.dart';
import 'package:flutter_health/screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _hidePass = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: ((context, state) {
          if (state is AuthenticatedState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
          if (state is AuthErrorState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Ooops...'),
                  content: Text(state.error),
                );
              },
            );
          }
        }),
        child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UnAuthState) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  border: OutlineInputBorder(),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null &&
                                          !EmailValidator.validate(value)
                                      ? 'Enter a valid email'
                                      : null;
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _passwordController,
                                obscureText: _hidePass,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(_hidePass
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _hidePass = !_hidePass;
                                      });
                                    },
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return value != null && value.length < 6
                                      ? 'Enter min. 6 characters'
                                      : null;
                                },
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _createAccountWithEmailAndPassword(context);
                                  },
                                  child: const Text('Sign Up'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInScreen()),
                              );
                            },
                            child: const Text("Sign In"),
                          ),
                        ],
                      ),
                      const Text("Or"),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ElevatedButton(
                          onPressed: () {
                            _authenticateWithGoogle(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              // ImageIcon(AssetImage("assets/icons/google.png")),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Login with Google')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }

  void _createAccountWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        SignUpRequested(_emailController.text, _passwordController.text),
      );
    }
    AchievementView(context,
            title: 'Congratulations!',
            subTitle: 'You sucessfull registration in app')
        .show();
    BlocProvider.of<GetAchievementsBloc>(context).add(UpdateAchievementsEvent(
        collectionPath: 'achievements',
        docPath: 'registration_achievement',
        dataNeedUpdate: const {'completed': true}));
  }

  void _authenticateWithGoogle(context) {
    BlocProvider.of<AuthBloc>(context).add(GoogleSignInRequested());
    AchievementView(context,
            title: 'Congratulations!',
            subTitle: 'You sucessfull registration in app')
        .show();
    BlocProvider.of<GetAchievementsBloc>(context).add(UpdateAchievementsEvent(
        collectionPath: 'achievements',
        docPath: 'registration_achievement',
        dataNeedUpdate: const {'completed': true}));
  }
}
