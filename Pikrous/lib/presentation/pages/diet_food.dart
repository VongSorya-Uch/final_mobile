import 'package:flutter/material.dart';

class DietFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Diet Food'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Image.asset('assets/food_image1.png', width: 100, height: 100),
                        SizedBox(height: 8),
                        Text('Name of the Food', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Image.asset('assets/food_image2.png', width: 100, height: 100),
                        SizedBox(height: 8),
                        Text('Name of the Food', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Image.asset('assets/food_image3.png', width: 100, height: 100),
                        SizedBox(height: 8),
                        Text('Name of the Food', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Image.asset('assets/food_image4.png', width: 100, height: 100),
                        SizedBox(height: 8),
                        Text('Name of the Food', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
