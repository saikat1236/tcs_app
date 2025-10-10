import 'package:flutter/material.dart';

class BorderedButton extends StatelessWidget {
  const BorderedButton(
      {Key? key, required this.text, required this.onPress, required this.icon})
      : super(key: key);

  final String text;
  final Function onPress;
  final Widget icon;
  final Color greenColor = const Color(0xFF00AF19);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: const Border(
            bottom: BorderSide(color: Colors.black),
            top: BorderSide(color: Colors.black),
            left: BorderSide(color: Colors.black),
            right: BorderSide(color: Colors.black),
          )),
      child: MaterialButton(
        minWidth: double.infinity,
        height: 60,
        onPressed: () {
          onPress();
        },
        color: Colors.yellowAccent,
        // color: greenColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: const TextStyle(
                  color: Colors.black,
                  // color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            // Spacer(),
            icon,
          ],
        ),
      ),
    );
  }
}
