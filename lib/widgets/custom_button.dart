import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String titulo;
  final void Function() goToHomePage;

  CustomButton({required this.titulo, required this.goToHomePage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 50,
            width: 300,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 245, 61, 55)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: Colors.orange)))),
              onPressed: () {
                this.goToHomePage();
              },
              child: Text(
                titulo,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          )
        ],
      ),
    );
  }
}
