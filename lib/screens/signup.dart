import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:atendimento_samu_app/services/auth/auth_service.dart';

import 'package:atendimento_samu_app/components/my_button.dart';
import 'package:atendimento_samu_app/components/my_text_field.dart';

class SignUp extends StatefulWidget {
  final void Function()? onTap;
  const SignUp({super.key, required this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final birthDateController = TextEditingController();
  final cpfController = TextEditingController();

  var dateMask = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var cpfMask = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  void signUp() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await authService.signUpWithEmailAndPassword(
          emailController.text,
          passwordController.text,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Os textos não conferem'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  'Registrar-se',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                MyTextField(
                  controller: emailController,
                  hintText: 'E-mail',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Senha',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirmar senha',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: birthDateController,
                  hintText: 'Data de nascimento',
                  obscureText: false,
                  mask: dateMask,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: cpfController,
                  hintText: 'CPF',
                  obscureText: false,
                  mask: cpfMask,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(onTap: signUp, text: 'Criar conta'),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text('Já possui conta?'),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Entrar',
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
    );
  }
}
