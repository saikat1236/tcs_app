import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tcs_app_fixed/pages/profile_drawer.dart';
import 'package:tcs_app_fixed/subhradeb/latest_job_news.dart';
import 'package:get/get.dart';
import 'homeScreen.dart';
import 'search_job_category.dart';
import 'search_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> with TickerProviderStateMixin {
  late TextEditingController nameController;

  // ---------- Scroll / Infinite loading ----------
  late final ScrollController _notificationController;
  bool _isLoadingMore = false;

  // Initial static data (you can replace with an API call later)
  final List<String> _initialNotifications = [
    'New opening for Software Engineer at TCS, apply by Oct 20, 2025',
    'Government of Tripura hiring 50 teachers, deadline Nov 1, 2025',
    'Bank PO vacancies announced, check eligibility now',
    'Skill Development Program for ITI graduates, enroll by Oct 15, 2025',
    'Self-Employment Loan Scheme launched, apply today',
    'Government of Tripura hiring 50 teachers, deadline Nov 1, 2025',
    'Bank PO vacancies announced, check eligibility now',
    'Skill Development Program for ITI graduates, enroll by Oct 15, 2025',
    'New opening for Software Engineer at TCS, apply by Oct 20, 2025',
    'Government of Tripura hiring 50 teachers, deadline Nov 1, 2025',
  ];

  final List<String> _initialLinks = List.filled(
      10, 'https://tpsc.tripura.gov.in/notice-board'); // 10 items

  // Dynamic lists that grow as the user scrolls
  final List<String> jobNotifications = [];
  final List<String> jobLinks = [];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: '');

    // Initialise scroll controller
    _notificationController = ScrollController()
      ..addListener(_scrollListener);

    // Load first page of data
    jobNotifications.addAll(_initialNotifications);
    jobLinks.addAll(_initialLinks);
  }

  @override
  void dispose() {
    nameController.dispose();
    _notificationController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  // ---------- Infinite scroll logic ----------
  void _scrollListener() {
    if (_notificationController.offset >=
            _notificationController.position.maxScrollExtent - 200 &&
        !_notificationController.position.outOfRange &&
        !_isLoadingMore) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;
    setState(() => _isLoadingMore = true);

    // Simulate network delay – replace with real API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      // Append another “page” (duplicate for demo)
      jobNotifications.addAll(_initialNotifications);
      jobLinks.addAll(_initialLinks);
      _isLoadingMore = false;
    });
  }

  // ---------- URL launcher ----------
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  // ---------- UI helpers ----------
  void displayDrawer(BuildContext context) =>
      Scaffold.of(context).openDrawer();

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

  Widget buildJobNotifications() {
    return Container(
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
        controller: _notificationController,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: jobNotifications.length + (_isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == jobNotifications.length) {
            // Loading indicator at the end
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final String text = jobNotifications[index];
          final String link = jobLinks[index];

          return GestureDetector(
            onTap: () => _launchUrl(link),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
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

          // Welcome card
          Container(
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              clipBehavior: Clip.hardEdge,
              elevation: 0,
              child: Container(
                color: Colors.blue.shade100,
                width: double.maxFinite,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo4.png', height: 80),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Welcome to',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 24,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          'Tripura Career Services',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Text(
                          'Directorate of Employment',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Services & Manpower Planning',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
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

          // Job notifications (infinite scroll)
          buildJobNotifications(),

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

          const SizedBox(height: 64),
        ],
      ),
    );
  }
}