import 'package:atendimento_samu_app/screens/chat.dart';
import 'package:atendimento_samu_app/widgets/custom_button.dart';
import 'package:atendimento_samu_app/widgets/custom_link.dart';
import 'package:atendimento_samu_app/widgets/custom_paginator.dart';
import 'package:atendimento_samu_app/widgets/custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:atendimento_samu_app/services/auth/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback callback;
  const OnboardingScreen({super.key, required this.callback});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Stack(children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            physics: const ClampingScrollPhysics(),
            children: [
              CustomSlider(
                  titulo: 'Seja bem vindo!',
                  texto: 'Utilize os serviços do SAMU de forma acessível.',
                  img: 'assets/3.png'),
              CustomSlider(
                  titulo: 'Atendimento simplificado',
                  texto:
                      'Abra um chamado de emergência rapidamente, sem esperas ',
                  img: 'assets/2.png'),
              CustomSlider(
                  titulo: 'Acessibilidade',
                  texto:
                      'Nosso sistema possui configurações exclusivas de acessibilidade, como suporte a língua brasileira de sinais',
                  img: 'assets/1.png'),
              CustomSlider(
                  titulo: 'Vamos começar',
                  texto:
                      'Cadastre-se ou entre com sua conta. Suas informações nos ajudam no atendimento',
                  img: 'assets/4.png'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 170.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPaginator(page: _currentPage),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  titulo: _currentPage == 3 ? 'Começar' : 'Próximo',
                  goToHomePage: _currentPage == 3 ? finishOnboarding : nextCard,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLink(
                    titulo: 'Emergencia',
                    goToHomePage: () => signInAnonymously(context))
              ],
            ),
          )
        ]),
      ),
    );
  }

  finishOnboarding() {
    _setState();
    widget.callback();
  }

  nextCard() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
  }

  _setState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final active = prefs.getBool('onboarding_completed') ?? false;

    if (!active) {
      await prefs.setBool('onboarding_completed', true);
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
    }
  }
}
