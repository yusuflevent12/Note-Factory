import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_mobil/src/providers/auth_provider.dart';
import 'package:frontend_mobil/src/widgets/common/CustomButton.dart';
import 'package:frontend_mobil/src/widgets/common/LoadingSpinner.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.user != null) {
        context.go('/home');
      }
    });

    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Tam Ad'),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-posta'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            CustomButton(
              text: 'Kayıt Ol',
              isLoading: authState.isLoading,
              onPressed: () {
                ref.read(authNotifierProvider.notifier).register(
                      _emailController.text,
                      _passwordController.text,
                      _fullNameController.text,
                    );
              },
            ),
            TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text('Zaten hesabın var mı? Giriş Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
