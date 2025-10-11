import 'dart:math';
import 'package:marquee/marquee.dart';
import 'package:flutter/material.dart';
// import 'package:tcs_app/pages/search/feed_screen.dart';
import 'package:tcs_app_fixed/pages/profile_drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tcs_app_fixed/subhradeb/latest_job_news.dart';
import 'package:get/get.dart';
import 'homeScreen.dart';
import 'search_job_category.dart';
import 'search_page.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> with TickerProviderStateMixin {
  late TextEditingController nameController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: '');
  }

  int currentIndex = 0;
  int currentIndex2 = 0;
  List<dynamic> productList = [];
  List<String> educationItems = [
    'Upto class 9',
    'class 10 passed',
    'class 12 passed',
    'Diploma after 10',
    'Diploma after 12',
    'Graduation',
    'P.G. Diploma',
    'Post Graduation',
    'Phd. or Specialist'
  ];
  var stateItems = [
    'All State'
        'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];

  var isAgelimit = true;
  var isEQ = false;
  var isState = false;

  // int _selectedColor = 0;
  // int _selectedState = 1;
  // int _selectedEQ = 1;

  var selectedRange = const RangeValues(16, 40);

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  Widget buildImageCarousel() {
    final List<String> imgList = [
      'assets/images/1.png',
      'assets/images/2.png',
      'assets/images/3.png',
      'assets/images/4.png',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.9,
      ),
      items: imgList
          .map((item) => Image.asset(
                item,
              ))
          .toList(),
    );
  }
    // Static list of job notifications
  final List<String> jobNotifications = [
    '1. New opening for Software Engineer at TCS, apply by Oct 20, 2025',
    '2. Government of Tripura hiring 50 teachers, deadline Nov 1, 2025',
    '3. Bank PO vacancies announced, check eligibility now',
    '4. Skill Development Program for ITI graduates, enroll by Oct 15, 2025',
    '5. Self-Employment Loan Scheme launched, apply today',
  ];

  Widget buildJobNotifications() {
    return Container(
      height: 150,
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Marquee(
        text: jobNotifications.join('\n\n'),
        style: const TextStyle(
          color: Colors.redAccent,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        scrollAxis: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        blankSpace: 20.0,
        velocity: 20.0,
        pauseAfterRound: const Duration(seconds: 2),
        startPadding: 10.0,
        accelerationDuration: const Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: const Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          'All Updates',
          style: TextStyle(fontSize: 18),
        ),
        icon: Icon(
          Icons.notifications_active,
          size: 28,
        ),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainHomeScreen()));
        },
      ),
      endDrawer: const ProfileDrawer(),
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        title: const Text(
          'Tripura Career Services',
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () => displayEndDrawer(context),
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            );
          })
        ],
      ),
      body: ListView(
        children: [
          // buildImageCarousel(),
          SizedBox(
            height: 20,
          ),
          Container(
            
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              clipBehavior: Clip.hardEdge,
              elevation: 0,
              child: Container(
                  color: Colors.blue.shade100,
                  width: double.maxFinite,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo4.png',
                        height: 80,
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome to',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 24,
                                color: Colors.blue.shade600),
                          ),
                          Text(
                            'Tripura Career Services',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          Text(
                            'Directorate of Employment',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey.shade600),
                          ),
                          Text(
                            'Services & Manpower Planning',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.grey.shade600),
                          ),
                   
                        ],
                      ),
                      Spacer(),
                    ],
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => JobNewsImageList());
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple.shade800,
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.fromLTRB(16, 16, 16, 4),
              width: double.maxFinite,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Latest Job News',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
           buildJobNotifications(),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: <Widget>[
                gridButton(
                  color: Colors.blue,
                  icon: Icons.search,
                  title: 'Search All Available Job Posts',
                  onPressed: () {
                    print('Search All Available Job Posts');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchJobCategory(),
                        ));
                  },
                ),
                gridButton(
                  color: Colors.green,
                  icon: Icons.school,
                  title: 'Skill Development Training',
                  onPressed: () {
                    print('Profile button pressed');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPage(
                                query: {'skillDevelopment': 'Skill'})));
                  },
                ),
                gridButton(
                  color: Colors.orange,
                  icon: Icons.business,
                  title: 'Employment Related Schemes',
                  onPressed: () {
                    print('Employement Related Schemes');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchPage(query: {'category': 'scheme'})));
                  },
                ),
                gridButton(
                  color: Colors.red,
                  icon: Icons.person,
                  title: 'Self-Employment Schemes/Loans',
                  onPressed: () {
                    print('Info button pressed');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPage(
                                query: {'category': 'Self-Employment'})));
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 64,
          ),
        ],
      ),
    );
  }
}

Widget gridButton(
    {required Color color,
    required IconData icon,
    required String title,
    required VoidCallback onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    onPressed: onPressed,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(icon, size: 50, color: Colors.white),
        SizedBox(height: 10),
        Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
