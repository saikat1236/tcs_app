import 'package:flutter/material.dart';

class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({super.key, required this.child});
  final Widget child;
  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(child: widget.child),
    // );
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      // backgroundColor: Colors.transparent,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.grey[600],
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close),
            )
          ],
        ),
      ),
      body: Center(
        child: widget.child,
        // child: AlertDialog(
        //   // title: new Text('You are my hero.'),
        //   insetPadding: EdgeInsets.zero,
        //   contentPadding: EdgeInsets.zero,
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   content: Container(
        //     width: MediaQuery.of(context).size.width,
        //     height: MediaQuery.of(context).size.height,
        //     child: widget.child,
        //   ),
        //   // actions: <Widget>[
        //   //   new IconButton(
        //   //     icon: CircleAvatar(
        //   //       child: Icon(Icons.edit),
        //   //       radius: 55,
        //   //     ),
        //   //     iconSize: 50,
        //   //     onPressed: Navigator.of(context).pop,
        //   //   ),
        //   // ],
        // ),
      ),
    );
  }
}
