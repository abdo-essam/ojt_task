import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/styles/app_text_styles.dart';
import '../blocs/login/login_cubit.dart';
import '../blocs/login/login_state.dart';
import '../../data/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../widgets/input_field.dart';
import '../widgets/sign_in_button.dart';
import '../widgets/register_text.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => LoginCubit(LoginUseCase(AuthRepository())),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login Successful')),
                );
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Wrong Email or Password')),
                  //SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Let’s Sign you in.",
                        style: AppTextStyles.titleStyle,
                      ),
                      const SizedBox(height: 8),
                      const Text("Welcome back.\nYou’ve been missed!" , style: AppTextStyles.subtitleStyle),
                      const SizedBox(height: 40),
                      InputField(
                        label: "Email",
                        hintText: "Your email",
                        controller: emailController,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        label: "Password",
                        hintText: "Password",
                        obscureText: true,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 180),
                      SignInButton(
                        onPressed: () {
                          final email = emailController.text;
                          final password = passwordController.text;
                          context.read<LoginCubit>().login(email, password);
                        },
                      ),
                      RegisterText(onPressed: () {}),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
