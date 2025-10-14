import 'package:flutter/material.dart';

import 'search/feed_screen.dart';
import 'profile_drawer.dart';
import 'search_page.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with TickerProviderStateMixin {
  // Future<void> secureScreen() async {
  //   // await FlutterWindowManager.addFlags(
  //   // FlutterWindowManager.FLAG_TRANSLUCENT_NAVIGATION);
  //   await FlutterWindowManager.addFlags(
  //       FlutterWindowManager.FLAG_TRANSLUCENT_STATUS);
  //   // await FlutterWindowManager.addFlags(
  //   //     FlutterWindowManager.FLAG_TRANSLUCENT_NAVIGATION);
  // }
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
    'Upto Class 9',
    'Class 10 Passed',
    'Class 12 Passed',
    'Diploma after Class 10',
    'Diploma after Class 12',
    'Graduate',
    'P.G. Diploma',
    'Post Graduate',
    'Phd. or Specialist'
  ];
  var stateItems = [
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
    'West Bengal'
  ];

  var isAgelimit = true;
  var isEQ = false;
  var isState = false;

  // int _selectedColor = 0;
  int _selectedState = 1;
  int _selectedEQ = 1;

  var selectedRange = const RangeValues(16, 40);

  // @override
  // void initState() {
  //   // appService = AppService(widget.sharedPreferences);
  //   // secureScreen();
  //   super.initState();
  // }
  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 253, 255),
      endDrawer: const ProfileDrawer(),
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 1,
                pinned: true,
                floating: true,
                snap: true,
                backgroundColor: Color.fromARGB(255, 14, 19, 100),
                leading: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
                toolbarHeight: 80,
                title: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
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
                  Builder(builder: (context) {
                    return IconButton(
                        onPressed: () => displayEndDrawer(context),
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ));
                  })
                ],
                bottom: AppBar(
                  automaticallyImplyLeading: false,
                  // backgroundColor: Color.fromARGB(255, 36, 84, 241),
                  actions: [
                    InkWell(
                      onTap: () => showFilterModal(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(right: 6, top: 4, bottom: 4),
                        // height: 30,
                        // width: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Apply Filter',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.filter_list,
                              color: Colors.black,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  title: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'All Updates',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: FeedScreen()
          ),
    );
  }

  showFilterModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(16),
            // color: Colors.amber.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filter by',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      minWidth: 40,
                      height: 40,
                      color: Colors.grey.shade300,
                      elevation: 0,
                      padding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ToggleButtons(
                        fillColor: Colors.indigo,
                        selectedColor: Colors.white,
                        children: <Widget>[
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Age-limit',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('Education Qualification'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('State'),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        onPressed: (int index) {
                          setState(() {
                            if (index == 0) {
                              setState(() {
                                isAgelimit = true;
                                isEQ = false;
                                isState = false;
                              });
                            } else if (index == 1) {
                              setState(() {
                                isAgelimit = false;
                                isEQ = true;
                                isState = false;
                              });
                            } else if (index == 2) {
                              setState(() {
                                isAgelimit = false;
                                isEQ = false;
                                isState = true;
                              });
                            }
                            setState(() {
                              isSelected = [false, false, false];
                              isSelected[index] = true;
                            });
                          });
                        },
                        isSelected: isSelected,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                isEQ
                    ? Expanded(
                        child: ListView.builder(
                          shrinkWrap: false,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: educationItems.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedEQ = index;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: _selectedEQ == index
                                        ? Colors.indigo
                                        : Colors.white,
                                    shape: BoxShape.rectangle),
                                width: 100,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    educationItems[index],
                                    style: TextStyle(
                                        color: _selectedEQ == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox.shrink(),
                isState
                    ? Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: stateItems.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedState = index;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                    color: _selectedState == index
                                        ? Colors.indigo
                                        : Colors.white,
                                    shape: BoxShape.rectangle),
                                width: 100,
                                height: 40,
                                child: Center(
                                  child: Text(
                                    stateItems[index],
                                    style: TextStyle(
                                        color: _selectedState == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : SizedBox.shrink(),
                isAgelimit
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(26, 12, 26, 12),
                        child: Row(
                          children: [
                            const Text(
                              'Age Range',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              '${selectedRange.start.round()}',
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 12),
                            ),
                            Text(" - ",
                                style: TextStyle(color: Colors.grey.shade500)),
                            Text(
                              '${selectedRange.end.round()}',
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
                isAgelimit
                    ? RangeSlider(
                        values: selectedRange,
                        min: 15,
                        max: 50,
                        divisions: 100,
                        inactiveColor: Colors.grey.shade300,
                        activeColor: Colors.indigo,
                        labels: RangeLabels(
                          '${selectedRange.start.round()}',
                          '${selectedRange.end.round()}',
                        ),
                        onChanged: (RangeValues values) {
                          setState(() => selectedRange = values);
                        })
                    : SizedBox.shrink(),
                isAgelimit ? Spacer() : Center(),
                SizedBox(
                  height: 16,
                ),
                button('Apply', () {
                  Navigator.pop(context);

                  // Let's show a snackbar when an item is added to the cart
                  const snackbar = SnackBar(
                    content: Text("Changes updated, reloading the page"),
                    duration: Duration(seconds: 5),
                    // action: SnackBarAction(
                    //   label: 'Undo',
                    //   onPressed: () {},
                    // ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchPage(
                              query: isAgelimit
                                  ? {
                                      'age':
                                          selectedRange.end.round().toString()
                                    }
                                  : isState
                                      ? {
                                          'state': stateItems[_selectedState]
                                              .toLowerCase()
                                        }
                                      : {
                                          'education':
                                              educationItems[_selectedEQ]
                                        })));
                }),
              ],
            ),
          );
        });
      },
    );
  }
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

addToCartModal(BuildContext context, TextEditingController nameController,
    TickerProvider ticker) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents the keyboard from resizing the screen
      body: Container(
        height: 600,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const Text(
                  "Search Jobs ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Type of jobs you are looking for..',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.all(18),
                  ),
                ),
              ],
            ),
            button('Search', () {
              Navigator.pop(context);

              // Let's show a snackbar when an item is added to the cart
              const snackbar = SnackBar(
                content: Text("Searched Successfully"),
                duration: Duration(seconds: 5),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(
                    query: {'search': nameController.text},
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    ),
  );
}

button(String text, Function onPressed) {
  return MaterialButton(
    onPressed: () => onPressed(),
    height: 50,
    elevation: 0,
    splashColor: Colors.yellow[700],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    color: Color.fromRGBO(29, 61, 243, 1),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
  );
}

class ChoiceOption extends StatelessWidget {
  final String text;

  const ChoiceOption({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(25),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      margin: const EdgeInsets.only(left: 10),
      child: Text(
        text,
        style: themeData.textTheme.bodyLarge,
      ),
    );
  }
}
