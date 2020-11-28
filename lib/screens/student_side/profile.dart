import 'package:TestGround/widgets/student_side/appDrawer.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text('Profile Screen'),
        ),
      ),
      
    );
  }
}
