import 'package:flutter/material.dart';

import 'colors.dart';


class AppDeveloperFooter extends StatelessWidget {
  const AppDeveloperFooter({super.key, this.topPadding = 30, this.bottomPadding = 30, this.showLogo = true});
  final double topPadding;
  final double bottomPadding;
  final bool showLogo;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: topPadding,
        ),
        !showLogo
            ? Container()
            : SizedBox(
                height: 20,
              ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              "Application From",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                // fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color.fromARGB(255, 186, 186, 186)
                    : textColor,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Directorate of Employment Services and Man-power Plannig",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color.fromARGB(255, 186, 186, 186)
                    : textColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              "Developed By",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                // fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark ? Color.fromARGB(255, 186, 186, 186) : textColor,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              "Interesting Technologies Pvt. Ltd.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark ? Color.fromARGB(255, 186, 186, 186) : textColor,
              ),
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 35),
        //     child: Text(
        //       "Made with ❤️ in Tripura, India. For the world.",
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         fontSize: 12,
        //         color: Theme.of(context).brightness == Brightness.dark ? Color.fromARGB(255, 186, 186, 186) : textColor,
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: bottomPadding,
        ),
      ],
    );
  }
}
