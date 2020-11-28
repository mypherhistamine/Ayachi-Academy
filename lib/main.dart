import 'package:TestGround/models/student_side/question.dart';
import 'package:TestGround/models/themeconsts.dart';
import 'package:TestGround/providers/auth.dart';
import 'package:TestGround/screens/sign_up_screen.dart';
import 'package:TestGround/screens/student_side/question_screen.dart';
import 'package:TestGround/screens/student_side/test_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:TestGround/screens/student_side/score_screen.dart';
// import 'package:TestGround/screens/teacher_side/timer_teacher_screen.dart';
// import 'package:TestGround/widgets/timerWidget.dart';
// import 'package:TestGround/screens/Clipper.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.getBool('isUserLoggedIn');

  runApp(
    MyApp(
        // isUserLogged: prefs.getBool('isUserLoggedIn'),
        // emailId: prefs.getString('email'),
        // password: prefs.getString('password')
        ),
  );
}

class MyApp extends StatelessWidget {
  final isUserLogged;
  final emailId;
  final password;
  // bool isLoading = false;

  MyApp({this.isUserLogged, this.emailId, this.password});

  Future<void> runner({Future<void> merFunc}) async {
    print('rishabh');

    return Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    // print(isUserLogged);
    // print(emailId);
    // print(password);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authenticator(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => QuestionPaper(),
        ),
      ],
      child: Consumer<Authenticator>(
        builder: (ctx, auth, _) => GetMaterialApp(
          defaultTransition: Transition.fadeIn,
          routes: {
            TestOverviewScreen.routeName: (ctx) => TestOverviewScreen(),
            QuestionScreen.routeName: (ctx) => QuestionScreen()
          },
          theme: ThemeData(
              fontFamily: 'Montserrat',
              primaryColor: ThemeConstants().blueColor,
              accentColor: Colors.cyan),
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          home: auth.isAuth
              ? TestOverviewScreen(
                  userId: auth.userId,
                )
              : SignUpScreen(),

          // : true //auth.isAuth
          //     ? TestOverviewScreen(
          //         userId: auth.userId,
          //       )
          //     : SignUpScreen(),
        ),
      ),
    );
  }
}

// auth.signIn({'emailId': 'mypherpro@gmail.com'},password: 'Mypher@99')

//auth.

// auth.isAuth ? TestOverviewScreen() : SignUpScreen()
// TestOverviewScreen(userId: auth.userId,)

// // auth.isAuth
//               ? TestOverviewScreen(
//                   userId: auth.userId,
//                 )
//               : SignUpScreen(),

// FutureBuilder(
// initialData: 'rishabh',
// future: auth.checker(),
// builder: (ctx, snapshot) {
//   if (snapshot.connectionState == ConnectionState.waiting) {
//     return Scaffold(
//         body: Center(child: CircularProgressIndicator()));
//   } else if (snapshot.connectionState == ConnectionState.done) {
//     print('done');

//     return TestOverviewScreen(
//       userId: '4O9ZNFOoNvNuIp0y0wpynzQbWJy2',
//     );
//   }
// })
