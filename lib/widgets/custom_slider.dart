import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  String titulo;
  String texto;
  String img;

  CustomSlider({required this.titulo, required this.texto, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 100),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  titulo,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64.0),
            child: Text(
              texto,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 16),
          Image(
            image: AssetImage(img),
            height: 200,
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
