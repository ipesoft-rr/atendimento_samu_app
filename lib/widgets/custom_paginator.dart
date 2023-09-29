import 'package:flutter/material.dart';

class CustomPaginator extends StatelessWidget {
  int page;

  CustomPaginator({required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: List.generate(4, (index) {
              return Container(
                margin: const EdgeInsets.all(4),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: index == page
                      ? Color.fromARGB(255, 230, 57, 70)
                      : Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
