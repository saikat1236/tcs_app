import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/pallete.dart';

class LightSwitch extends ConsumerStatefulWidget {
  const LightSwitch({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LightSwitchState();
}

class _LightSwitchState extends ConsumerState<LightSwitch>
    with SingleTickerProviderStateMixin {
  late bool _isOn;

  // late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void toggleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    // _scale = 1 - _controller.value;
    _isOn = ref.watch(themeNotifierProvider.notifier).mode == ThemeMode.light;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Positioned(
          //   top: 0,
          //   bottom: 0,
          //   right: 0,
          //   left: 0,
          //   child: AnimatedContainer(
          //     duration: Duration(milliseconds: 300),
          //     color: _isOn ? Color.fromARGB(180, 232, 113, 54) : Color.fromARGB(255, 155, 40, 40),
          //   ),
          // ),
          Positioned(
            top: 0,
            left: 50,
            child: Container(
              height: 60,
              width: 2,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          _isOn
              ? Positioned(
                  bottom: 0,
                  top: 1,
                  right: 1,
                  left: 25,
                  child: Transform.scale(
                    scale: 0.7,
                    child: Transform.rotate(
                        angle: 3.15,
                        child: GestureDetector(
                            onTapDown: _tapDown,
                            onTapUp: _tapUp,
                            onTap: () {
                              toggleTheme(ref);
                              setState(() {});
                              // setState(() {
                              //   _isOn = false;
                              // });
                            },
                            child:
                                Image.asset('assets/images/light_bulb.png'))),
                  ),
                )
              : Positioned(
                  bottom: 0,
                  top: 1,
                  right: 1,
                  left: 25,
                  child: Transform.scale(
                    scale: 0.7,
                    child: Transform.rotate(
                        angle: 3.15,
                        child: GestureDetector(
                            onTapDown: _tapDown,
                            onTapUp: _tapUp,
                            onTap: () {
                              toggleTheme(ref);
                              setState(() {});
                              // setState(() {
                              //   _isOn = true;
                              // });
                            },
                            child: Image.asset('assets/images/dark_bulb.png'))),
                  ),
                )
        ],
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
