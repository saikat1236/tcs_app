import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tcs_app/pages/homeScreen.dart';
import 'package:tcs_app_fixed/pages/search/feed_screen.dart';

import 'package:tcs_app_fixed/pages/search/search_feed.dart';

class SearchPage extends ConsumerWidget {
  final Map query;
  const SearchPage({required this.query, super.key});

  // @override
  // ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();

  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  // TODO: implement build
  // throw UnimplementedError();
  // }
// }

// class _SearchPageState extends ConsumerState<SearchPage> {
  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('query' + query.toString());

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 253, 255),
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 14, 19, 100),
      //   elevation: 1,
      //   automaticallyImplyLeading: false,
      //   leading: InkWell(
      //     onTap: () => Navigator.pop(context),
      //     child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,),
      //   ),
      //   title: Text('Search Page', style: TextStyle(color: Colors.white),),
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // backgroundColor: ColorSys.primary,
        backgroundColor: Color.fromARGB(255, 14, 19, 100),
        leading: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        // leading:
        // centerTitle: true,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              // const Text(
              //   '|',
              //   style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 25,
              //       fontWeight: FontWeight.w200),
              // ),
              //     Padding(
              // padding: const EdgeInsets.all(0.0),
              // child: Image.asset(
              //   'assets/images/logo.png',
              //   // scale: 0.5,
              //   // fit: BoxFit.fitWidth,
              //   width: 40,
              // ),
              // ),
              const Text(
                'Tripura Career Service',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          // IconButton(
          //     onPressed: () => addToCartModal(context, nameController, this),
          //     icon: const Icon(
          //       Icons.search,
          //       color: Colors.white,
          //     )),
          // IconButton(
          //     onPressed: () async {
          //       try {
          //         final prefs = await SharedPreferences.getInstance();
          //         prefs.setBool('showHome', false);
          //         // prefs.setBool('shoeLang', true);
          //         AuthService().signOut();
          //       } finally {
          //         Navigator.of(context).pushReplacement(
          //             MaterialPageRoute(builder: (context) {
          //           return const OnBoarding();
          //         }));
          //       }
          //     },
          //     icon: const Icon(
          //       Icons.logout_rounded,
          //       color: Colors.black,
          //     )),
          // Builder(builder: (context) {
          //   return IconButton(
          //       onPressed: () => displayEndDrawer(context),
          //       icon: const Icon(
          //         Icons.menu,
          //         color: Colors.white,
          //       ));
          // })
        ],
      ),
      // drawer: const ProfileDrawer(),

      body: Responsive(
          child: SearchFeed(
        query: query,
      )),
    );
  }
}
