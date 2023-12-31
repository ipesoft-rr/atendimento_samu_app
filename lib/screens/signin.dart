import 'package:atendimento_samu_app/screens/chat.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:atendimento_samu_app/services/auth/auth_service.dart';

import 'package:atendimento_samu_app/components/my_button.dart';
import 'package:atendimento_samu_app/components/my_text_field.dart';

class SignIn extends StatefulWidget {
  final void Function()? onTap;
  const SignIn({super.key, required this.onTap});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    setState(() {
      loading = true;
    });
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void signInAnonymously(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
        'anonimo@gmail.com',
        '12345678',
      );
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChatScreen(
            receiverUserEmail: 'ipe@gmail.com',
            receiverUserID: 'v6CrEksU4dafuKK3qxcYfiDehP72',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.message,
                      size: 80,
                      color: Colors.white,
                    ),
                    const Image(
                      image: AssetImage('assets/logo-red.png'),
                      height: 100,
                    ),
                    const Text(
                      'Bem vindo!',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    loading
                        ? const CircularProgressIndicator()
                        : MyButton(onTap: signIn, text: 'Entrar'),
                    TextButton(
                      onPressed: () {
                        signInAnonymously(context);
                      },
                      child: const Text('Emergência'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text('Não possui conta?'),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Registrar-se',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
