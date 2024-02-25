// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pikrous/api/endpoint/home_endpoint.dart';
import 'package:pikrous/helper/utils/colors.dart';
import 'package:pikrous/helper/utils/constants.dart';
import 'package:pikrous/helper/utils/preference.dart';
import 'package:pikrous/presentation/items/drawer_component.dart';
import 'package:pikrous/presentation/items/search_bar.dart';
import 'package:pikrous/presentation/pages/admin/create_doctor.dart';
import 'package:pikrous/presentation/pages/all_categories_page.dart';
import 'package:pikrous/presentation/pages/all_doctors_page.dart';
import 'package:pikrous/presentation/pages/auth/login_page.dart';
import 'package:pikrous/presentation/pages/doctor_page.dart';
import 'package:pikrous/presentation/pages/doctors/view_all_doctor.dart';
import 'package:pikrous/presentation/pages/calendar_page.dart';
import 'package:pikrous/presentation/pages/all_dietbete_page.dart';
import 'package:pikrous/presentation/pages/diet_food.dart';

import '../items/bottom_nav_bar.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

List<String> categories = [
  'All',
  'Diet Food',
  'Old Food',
  'Vegan Food',
  'Dietbete Food',
];

List<String> categoriesImage = [
  'lib/assets/images/foodlogo.jpg',
  'lib/assets/images/diet_food.png',
  'lib/assets/images/old_food.jpg',
  'lib/assets/images/vegan.jpg',
  'lib/assets/images/diet.png',
];

class _HomePageState extends State<HomePage> {
  List<String> names = [];
  List<String> expertise = [];
  dynamic userData;
  late int role;

  @override
  void initState() {
    super.initState();
    userData = AppPreference.getUserData();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(apiLink + HomeEndPoint.alldoctor),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        setState(() {
          if (data.isNotEmpty && data[0] is List) {
            List<dynamic> doctors = data[0];

            // Use the take method to get only the first 5 elements
            List<dynamic> firstFiveDoctors = doctors.take(5).toList();

            names = firstFiveDoctors
                .map((item) => item['name'] ?? '')
                .cast<String>()
                .toList();
            expertise = firstFiveDoctors
                .map((item) => item['expertise'] ?? '')
                .cast<String>()
                .toList();
          } else {
            print('Invalid data structure: $data');
            names = [];
            expertise = [];
          }
        });

        print('Example field: $data');
      } else {
        print('Failed to load data. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: userData['role'] == 1
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                title: const Text(
                  "Login As Admin",
                  style: TextStyle(color: Colors.white),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: const Text('Logout'), // Use widget.title here
                          content:
                              const Text("Are you sure you want to logout?"),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoDialogAction(
                              child: const Text(
                                'Logout',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                              onPressed: () {
                                AppPreference.clearUserData();
                                AppPreference.clearSaveAccess();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              body: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateDoctor()));
                      },
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Text(
                                'Create A Doctor Account',
                                style: TextStyle(fontSize: 18),
                              ),
                              const Spacer(),
                              Image.network(
                                'https://cdn-icons-png.flaticon.com/512/9193/9193824.png',
                                width: 70,
                                height: 70,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewALlDoctors()));
                      },
                      child: Container(
                        height: 100,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Text(
                                'View All Doctors',
                                style: TextStyle(fontSize: 18),
                              ),
                              const Spacer(),
                              Image.network(
                                'https://cdn-icons-png.flaticon.com/512/3017/3017149.png',
                                width: 70,
                                height: 70,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Scaffold(
              // child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor.withOpacity(0.63),
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                title: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: const Text(
                        'Welcome to Healtify',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ClipOval(
                      child: Image.asset(
                        'lib/assets/images/me.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(120),
                  child: Container(
                    height: 120,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 20),
                    decoration: const BoxDecoration(
                      // color: Colors.blue, // Change to your desired color
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Eat Healthy, Stay Healthy, \n Live Healthy",
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(80),
                    bottomStart: Radius.circular(80),
                  ),
                ),
              ),
              drawer: const Drawer(
                child: DrawerComponent(),
              ),
              body: Stack(
                children: [
                  // SingleChildScrollView(
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            const SearchBarInput(
                              label: 'Search Catagory',
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              'Categories',
                              style: TextStyle(fontSize: 20),
                            ),
                            Container(
                              height: 120,
                              margin: const EdgeInsets.only(top: 20),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categoriesImage.length,
                                itemBuilder: ((context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (index == 0) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const AllCategories())));
                                      } else if (index == 1) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const DietFoodPage())));
                                      } else if (index == 2) {
                                      } else if (index == 3) {
                                      } else if (index == 4) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const AllDietbetes())));
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: index > 0 ? 23 : 0),
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: const Color(0xfffeeeeee),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: Image.asset(
                                                categoriesImage[index]),
                                          ),
                                        ),
                                        Container(
                                          width: 80,
                                          margin: EdgeInsets.only(
                                              left: index > 0 ? 23 : 0),
                                          child: Text(
                                            categories[index],
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(
                              height: 200,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        const CalendarPage()),
                                  ),
                                );
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.63),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Create Food Schedule",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AllDoctors(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0XFFFEEEEEE)),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 219,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          // shrinkWrap: false,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: names.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const DoctorPage(),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: index > 0 ? 15 : 0,
                                    bottom: index == names.length - 1 ? 80 : 0),
                                width: MediaQuery.of(context).size.width,
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color(0xfffeeeeee),
                                    width: 5.0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 20),
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                'lib/assets/images/icon.png',
                                                width: 70,
                                                height: 70,
                                              ),
                                              const Positioned(
                                                right: 0,
                                                top: 0,
                                                child: Icon(
                                                  Icons.circle,
                                                  color: Colors.greenAccent,
                                                  size: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.greenAccent,
                                            ),
                                            Text('4.9'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Text(
                                                  names[index],
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xfffeeeeee),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Center(
                                                  child: Text(
                                                    '\$15',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(expertise[index]),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xfffeeeeee),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      'Appointment',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xfffeeeeee),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const Icon(
                                                    Icons.message,
                                                    color: Color(0xfffb28cff),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                    color: const Color(
                                                        0xfffeeeeee),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: const Icon(
                                                    Icons
                                                        .favorite_border_outlined,
                                                    color: Color(0xfffff9a9a),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // ),
                  const Positioned(
                    bottom: 10,
                    left: 20,
                    child: BottomNavBar(index: 1),
                  ),
                ],
              ),
            ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
