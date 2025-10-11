import 'package:flutter/material.dart';
import 'package:tcs_app_fixed/pages/profile_drawer.dart';

// import 'homeScreen.dart';
// import 'homeScreen.dart';
import 'search_page.dart';

class GovJobListing extends StatefulWidget {
  const GovJobListing({Key? key}) : super(key: key);

  @override
  State<GovJobListing> createState() => _GovJobListingState();
}

class _GovJobListingState extends State<GovJobListing>
    with TickerProviderStateMixin {
  late TextEditingController nameController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: '');
  }

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: const ProfileDrawer(),
        backgroundColor: Color.fromARGB(255, 239, 253, 255),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: ColorSys.primary,
          backgroundColor: Color.fromARGB(255, 14, 19, 100),
          leading: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Image.asset(
              'assets/images/logo.png',
              // scale: 0.5,
              // fit: BoxFit.fitWidth,
              // width: 40,
            ),
          ),
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
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Image.asset(
                //     'assets/images/lock_logo.png',
                //     fit: BoxFit.contain,
                //     width: 40,
                //   ),
                // ),
                const Text(
                  'Tripura Career Services',
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
            //       color: Colors.black,
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
            // IconButton(
            //   onPressed: () => addToCartModal(context, nameController, this),
            //   icon: const Icon(
            //     Icons.search,
            //     color: Colors.white,
            //   )),
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () => displayEndDrawer(context),
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ));
            })
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Government Job Listing',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(5.0),
              //   child: Text(
              //     'Find The Latest Jobs, Schemes and Loans',
              //     style: TextStyle(fontSize: 15, color: Colors.black),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(
              //     'From Tripura Government and Central Government',
              //     style: TextStyle(fontSize: 15, color: Colors.black),
              //   ),
              // ),

              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchPage(query: {'state': 'other'}))),
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 1, // Spread radius
                        blurRadius: 1, // Blur radius
                        offset: Offset(0, 1), // Offset in the x and y direction
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //  Icon(Icons.business_outlined,color: Colors.black),

                      Text(
                        'Opening by Central / State Govt.',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded,
                          color: Colors.black),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchPage(query: {'state': 'tripura'}))),
                child: Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 1, // Spread radius
                        blurRadius: 1, // Blur radius
                        offset: Offset(0, 1), // Offset in the x and y direction
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon(Icons.corporate_fare_outlined, color: Colors.black),

                      Text(
                        'Opening by Government of Tripura',
                        style: TextStyle(color: Colors.black),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded,
                          color: Colors.black),
                    ],
                  ),
                ),
              ),
            ]))));
  }
}
