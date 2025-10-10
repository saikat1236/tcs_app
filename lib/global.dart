import 'package:flutter/material.dart';

class Choice {
  final String title;
  final String label;

  Choice({required this.title, required this.label});
}

Widget _indicator(bool isActive) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    height: 10,
    width: 10,
    margin: const EdgeInsets.only(right: 5),
    curve: Curves.easeIn,
    decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(color: Colors.white),
          top: BorderSide(color: Colors.white),
          right: BorderSide(color: Colors.white),
          left: BorderSide(color: Colors.white),
        ),
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20)),
  );
}

List<Widget> buildIndicator(int currentIndex) {
  List<Widget> indicators = [];
  for (int i = 0; i < 3; i++) {
    if (currentIndex == i) {
      indicators.add(_indicator(true));
    } else {
      indicators.add(_indicator(false));
    }
  }

  return indicators;
}

Widget makePage({image, title, onPress}) {
  return Container(
    // color: Colors.grey,
    // padding: const EdgeInsets.only(
    //   left: 20,
    //   right: 20,
    // ),
    // margin: const EdgeInsets.only(bottom: 80, top: 10),
    decoration: BoxDecoration(
        // color: Colors.amber,
        borderRadius: BorderRadius.circular(20)),
    child: Image.asset(
      image,
      // height: MediaQuery.of(context).size.height / 7,
      // fit: BoxFit.cover,
      fit: BoxFit.contain,
    ),
  );
}
