// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:pikrous/helper/utils/colors.dart';
import 'package:pikrous/presentation/items/search_bar.dart';
import 'package:pikrous/presentation/pages/all_doctors_page.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

List<String> problems = [
  'Grenn food',
  'Menstraution Probm',
  'Uterus',
  'Pregnancy Issue',
  'Breast Issue',
];

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Food Category'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Row(
            children: [
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 2,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Foods',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SearchBarInput(label: 'Search food'),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: problems.length,
                itemBuilder: ((context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    margin: EdgeInsets.only(top: index > 0 ? 20 : 0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0XFFFEEEEEE), width: 2.0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 50,
                          height: 50,
                          child: Image.asset('lib/assets/images/food.png'),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: Text(problems[index],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
