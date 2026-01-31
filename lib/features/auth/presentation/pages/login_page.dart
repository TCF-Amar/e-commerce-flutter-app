import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/app_scaffold.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/app_text.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/exit_on_double_tap.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExitOnDoubleBack(
      child: AppScaffold(
        appBar: AppBar(toolbarHeight: 0, backgroundColor: Colors.transparent),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              SizedBox(
                // height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    AppText(
                      'Welcome Back',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 8),
                    AppText('Sign in to your account', fontSize: 16),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              LoginForm(),

              const SizedBox(height: 24),

              SizedBox(
                // height: 50,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: AppText('Or', fontSize: 16),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppText('Don\'t have an account? ', fontSize: 16),
                        InkWell(
                          onTap: () => context.push('/register'),
                          child: const AppText(
                            'Register',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
