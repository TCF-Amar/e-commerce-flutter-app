import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/features/auth/presentation/widgets/register_form.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
                    'Create Account',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 8),
                  AppText('Create an account', fontSize: 16),
                ],
              ),
            ),

            const SizedBox(height: 24),

            RegisterForm(),
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
                      AppText('Already have an account? ', fontSize: 16),
                      InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: AppText(
                          'Login',
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
    );
  }
}
