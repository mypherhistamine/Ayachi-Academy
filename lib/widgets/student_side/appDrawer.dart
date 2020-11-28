import 'package:TestGround/screens/student_side/profile.dart';
import 'package:TestGround/screens/student_side/test_overview_screen.dart';
// import 'package:TestGround/screens/teacher_side/test_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.65,
      child: Drawer(
        child: Column(
          children: [
            AppBar(
              title: Text(
                "Ayachi Academy",
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
              automaticallyImplyLeading: false,
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.cast_for_education),
              title: Text('Upcoming Tests'),
              onTap: () {
                Get.off(TestOverviewScreen());
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Profile'),
              onTap: () {
                Get.off(Profile());
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.screen_lock_landscape),
              title: Text('Completed Test'),
              onTap: () {},
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
