import 'package:atendimento_samu_app/screens/home_screen.dart';
import 'package:atendimento_samu_app/widgets/custom_button.dart';
import 'package:atendimento_samu_app/widgets/custom_link.dart';
import 'package:atendimento_samu_app/widgets/custom_paginator.dart';
import 'package:atendimento_samu_app/widgets/custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Stack(children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            physics: ClampingScrollPhysics(),
            children: [
              CustomSlider(
                  titulo: 'Seja bem vindo!',
                  texto: 'Utilize os serviços do SAMU de forma acessível.'),
              CustomSlider(
                  titulo: 'Atendimento simplificado',
                  texto:
                      'Abra um chamado de emergência rapidamente, sem esperas '),
              CustomSlider(
                  titulo: 'Acessibilidade',
                  texto:
                      'Nosso sistema possui configurações exclusivas de acessibilidade, como suporte a língua brasileira de sinais'),
              CustomSlider(
                  titulo: 'Vamos começar',
                  texto:
                      'Cadastre-se ou entre com sua conta. Suas informações nos ajudam no atendimento'),
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
                  titulo: _currentPage == 3 ? 'Cadastrar-se' : 'Próximo',
                  goToHomePage: _currentPage == 3 ? goToHomePage : nextCard,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLink(titulo: 'Emergencia', goToHomePage: goToHomePage)
              ],
            ),
          )
        ]),
      ),
    );
  }

  goToHomePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));

    _setState();
  }

  nextCard() {
    _pageController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }

  _setState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final active = prefs.getBool('ativo') ?? false;

    if (!active) {
      await prefs.setBool('ativo', true);
    }
  }
}
