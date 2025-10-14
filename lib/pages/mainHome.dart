import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tcs_app_fixed/pages/profile_drawer.dart';
import 'package:tcs_app_fixed/subhradeb/latest_job_news.dart';
import 'package:get/get.dart';
import 'homeScreen.dart';
import 'search_job_category.dart';
import 'search_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:marquee/marquee.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> with TickerProviderStateMixin {
  late TextEditingController nameController;
  late AnimationController _controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // Adjust speed of scrolling
    )..addListener(() {
        if (_scrollController.hasClients) {
          double maxExtent = _scrollController.position.maxScrollExtent;
          double currentOffset = _scrollController.offset;
          double newOffset = currentOffset + 1; // Adjust scrolling speed
          if (newOffset >= maxExtent) {
            _scrollController.jumpTo(0); // Loop back to start
          } else {
            _scrollController.jumpTo(newOffset);
          }
        }
      });

    _controller.repeat(); // Continuous scrolling
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // ---------- Scroll / Infinite loading ----------
  // Static list of job notifications
  final List<String> jobNotifications = [
    '* New opening for Software Engineer at TCS, apply by Oct 20, 2025',
    '* Government of Tripura hiring 50 teachers, deadline Nov 1, 2025',
    '* Bank PO vacancies announced, check eligibility now',
    '* Skill Development Program for ITI graduates, enroll by Oct 15, 2025',
    '* Self-Employment Loan Scheme launched, apply today',
  ];
  final List<String> links = [
    'https://www.tcs.com/careers',
    'https://www.tcs.com/careers/teacher',
    'https://www.tcs.com/careers/bank-po',
    'https://www.tcs.com/careers/skill-development-program',
    'https://www.tcs.com/careers/self-employment-loan-scheme',
  ];
//   final List<String> links = ['https://www.google.com']; // Single valid URL
// final List<String> jobNotifications = ['* Test1 notification'];

  // Widget buildJobNotifications() {
  //   return Container(
  //     height: 200,
  //     margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
  //     padding: const EdgeInsets.all(15),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10.0),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.3),
  //           spreadRadius: 2,
  //           blurRadius: 5,
  //           offset: const Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: Marquee(
  //       text: jobNotifications.join('\n\n'),
  //       style: const TextStyle(
  //         color: Colors.blueAccent,
  //         fontSize: 14,
  //         fontWeight: FontWeight.w500,
  //       ),
  //       scrollAxis: Axis.vertical,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       blankSpace: 20.0,
  //       velocity: 20.0,
  //       pauseAfterRound: const Duration(seconds: 2),
  //       startPadding: 10.0,
  //       accelerationDuration: const Duration(seconds: 1),
  //       accelerationCurve: Curves.linear,
  //       decelerationDuration: const Duration(milliseconds: 500),
  //       decelerationCurve: Curves.easeOut,
  //     ),
  //   );
  // }
 
  Widget buildJobNotifications() {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          height: 200,
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
          child: ListView.builder(
            controller: _scrollController,
            itemCount: jobNotifications.length * 100,
            itemBuilder: (context, index) {
              final notificationIndex = index % jobNotifications.length;
              return GestureDetector(
                onTap: () async {
                  if (notificationIndex >= links.length) {
                    print('Error: notificationIndex $notificationIndex exceeds links length ${links.length}');
                    return;
                  }
                  final url = Uri.parse(links[notificationIndex]);
                  print('Tapped notification #$notificationIndex: ${jobNotifications[notificationIndex]} -> $url');
                  try {
                    print('Checking if URL can be launched: $url');
                    if (await canLaunchUrl(url)) {
                      print('Launching URL: $url');
                      await launchUrl(url, mode: LaunchMode.platformDefault);
                    } else {
                      print('Cannot launch URL: $url');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Cannot launch ${links[notificationIndex]}')),
                      );
                    }
                  } catch (e) {
                    print('Error launching URL $url: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error launching URL: $e')),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    jobNotifications[notificationIndex],
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void displayEndDrawer(BuildContext context) =>
      Scaffold.of(context).openEndDrawer();

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
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.9,
      ),
      items: imgList
          .map((item) => Image.asset(item, fit: BoxFit.cover))
          .toList(),
    );
  }



  // ---------- Grid button ----------
  Widget gridButton({
    required Color color,
    required IconData icon,
    required String title,
    required VoidCallback onPressed,
  }) {
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
        children: [
          Icon(icon, size: 50, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- State lists (unchanged) ----------
  final List<String> educationItems = [
    'Upto class 9',
    'class 10 passed',
    'class 12 passed',
    'Diploma after 10',
    'Diploma after 12',
    'Graduation',
    'P.G. Diploma',
    'Post Graduation',
    'Phd. or Specialist',
  ];

  final List<String> stateItems = [
    'All State',
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
    'West Bengal',
  ];

  final bool isAgelimit = true;
  final bool isEQ = false;
  final bool isState = false;
  final RangeValues selectedRange = const RangeValues(16, 40);

  // ---------- Build ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          'All Updates',
          style: TextStyle(fontSize: 18),
        ),
        icon: const Icon(Icons.notifications_active, size: 28),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MainHomeScreen()),
          );
        },
      ),
      endDrawer: const ProfileDrawer(),
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset('assets/images/logo.png'),
        ),
        title: const Text('Tripura Career Services'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () => displayEndDrawer(context),
              icon: const Icon(Icons.menu, color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),

        



          // Job notifications (infinite scroll)
          // buildJobNotifications(),

          // Grid of action buttons
          Container(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                gridButton(
                  color: Colors.blue,
                  icon: Icons.search,
                  title: 'Search All Available Job Posts',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SearchJobCategory(),
                      ),
                    );
                  },
                ),
                gridButton(
                  color: Colors.green,
                  icon: Icons.school,
                  title: 'Skill Development Training',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchPage(
                          query: const {'skillDevelopment': 'Skill'},
                        ),
                      ),
                    );
                  },
                ),
                gridButton(
                  color: Colors.orange,
                  icon: Icons.business,
                  title: 'Employment Related Schemes',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchPage(
                          query: const {'category': 'scheme'},
                        ),
                      ),
                    );
                  },
                ),
                gridButton(
                  color: Colors.red,
                  icon: Icons.person,
                  title: 'Self-Employment Schemes/Loans',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SearchPage(
                          query: const {'category': 'Self-Employment'},
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
                    // Latest Job News button
          InkWell(
            onTap: () => Get.to(() =>  JobNewsImageList()),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple.shade800,
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              width: double.maxFinite,
              padding: const EdgeInsets.all(16),
              child: const Row(
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
          SizedBox(height: 16),
          buildJobNotifications(),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}