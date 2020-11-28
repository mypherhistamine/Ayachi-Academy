import 'package:TestGround/models/student_side/question.dart';
import 'package:TestGround/models/themeconsts.dart';
import 'package:TestGround/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool teacherEnabled = true;
  bool studentEnabled = false;
  double varHeight = 0;
  String password = '';
  List<String> classes = ['6,7,8,9,10,11,12'];
  int classNumber;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  bool isSignUp = true;

  var userDetails = {
    'firstName': '',
    'lastName': '',
    'emailId': '',
    'userName': '',
    'classNumber': '',
    'role': 'student',
    'assigned': [''],
    'completed': [''],
  };

  Widget _buildFirstNameField() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: 120,
        height: 50,
        child: TextFormField(
          onChanged: (value) {
            userDetails['firstName'] = value;
          },
          style: TextStyle(fontFamily: 'Montserrat'),
          enabled: true,
          decoration: InputDecoration(
              labelStyle: TextStyle(fontFamily: 'Montserrat'),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.cyan, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.cyan, width: 1),
              ),
              hintText: 'First Name'),
          validator: (value) {
            if (value.isEmpty) {
              return '*Required Field';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildLastNameField() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: 120,
        height: 50,
        child: TextFormField(
          onChanged: (value) {
            userDetails['lastName'] = value;
          },
          style: TextStyle(fontFamily: 'Montserrat'),
          cursorColor: Colors.red,
          decoration: InputDecoration(
            labelStyle: TextStyle(fontFamily: 'Montserrat'),
            labelText: 'Last Name',
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: Colors.cyan, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.cyan, width: 1),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailIDField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: TextFormField(
        style: TextStyle(fontFamily: 'Montserrat'),
        onChanged: (value) {
          userDetails['emailId'] = value;
        },
        decoration: InputDecoration(
          labelStyle: TextStyle(fontFamily: 'Montserrat'),
          labelText: 'Email ID',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.cyan, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.cyan, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildUserNameField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: TextFormField(
        onChanged: (value) {
          userDetails['userName'] = value;
        },
        style: TextStyle(fontFamily: 'Montserrat'),
        decoration: InputDecoration(
          labelStyle: TextStyle(fontFamily: 'Montserrat'),
          labelText: 'Username',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.cyan, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.cyan, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildClassIDField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: TextFormField(
        onChanged: (value) {
          userDetails['classNumber'] = value;
        },
        style: TextStyle(fontFamily: 'Montserrat'),
        decoration: InputDecoration(
          labelStyle: TextStyle(fontFamily: 'Montserrat'),
          labelText: 'Class studying',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.cyan, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.cyan, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildClassField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: TextFormField(
        style: TextStyle(fontFamily: 'Montserrat'),
        decoration: InputDecoration(
          labelStyle: TextStyle(fontFamily: 'Montserrat'),
          labelText: 'Classroom ID',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.cyan, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.cyan, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: TextFormField(
        style: TextStyle(fontFamily: 'Montserrat'),
        obscureText: true,
        onChanged: (value) {
          password = value;
        },
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(fontFamily: 'Montserrat'),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.cyan, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.cyan, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Consumer<Authenticator>(
      builder: (ctx, data, _) => Container(
        height: 54,
        width: 163,
        child: RaisedButton(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
          color: ThemeConstants().submitBlack,
          onPressed: () async {
            // print(userDetails);
            // _formKey.currentState.validate();
            // data.signUpWithdetails(userDetails, password: password);
            setState(() {
              isLoading = true;
            });
            // await data.signIn(userDetails, password: password);

            isSignUp
                ? await data.signUpWithdetails(userDetails, password: password)
                : await data.signIn(userDetails, password: password);
            setState(() {
              isLoading = false;
            });
          },
          child: Text(
            isSignUp ? 'SIGN UP' : 'SIGN IN',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: 'Montserrat'),
          ),
        ),
      ),
    );

    // return Consumer<QuestionPaper>(
    //   builder: (ctx, data, _) => FlatButton(
    //       onPressed: () async {
    //         var value =
    //            await data.getQuestionPapers(userId: 'EwF16fnhpgbYIBnoj5SdojZOzcp1');
    //         print(value);
    //       },
    //       child: Text('Choot')),
    // );
  }

  Widget _buildChips() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      child: Row(
        children: [
          ActionChip(
            elevation: 2,
            onPressed: () {
              setState(() {
                teacherEnabled = !teacherEnabled;
                studentEnabled = !studentEnabled;
                userDetails['role'] = 'teacher';
              });
            },
            label: Text(
              'Teacher',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            backgroundColor:
                teacherEnabled ? ThemeConstants().grey : Colors.blue,
          ),
          SizedBox(width: 10),
          ActionChip(
            onPressed: () {
              setState(() {
                studentEnabled = !studentEnabled;
                teacherEnabled = !teacherEnabled;
                userDetails['role'] = 'student';
              });
            },
            elevation: 2,
            label: Row(
              children: [
                SvgPicture.asset('assets/images/student_icon.svg',
                    color: Colors.white, height: 20),
                SizedBox(width: 4),
                Text(
                  'Student',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            backgroundColor:
                studentEnabled ? ThemeConstants().grey : Colors.blue,
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              margin: EdgeInsets.only(top: 40),
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'A',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 100,
                              fontFamily: 'Montserrat'),
                        ),
                        Text(
                          'A',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 100,
                              fontFamily: 'Montserrat'),
                        )
                      ],
                    ),
                  ),
                  Text(
                    'Ayachi Academy',
                    style: TextStyle(fontSize: 40, fontFamily: 'Montserrat'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isSignUp
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildFirstNameField(),
                            SizedBox(
                              width: 10,
                            ),
                            _buildLastNameField(),
                          ],
                        )
                      : SizedBox(),
                  _buildEmailIDField(),
                  isSignUp ? _buildUserNameField() : SizedBox(),
                  _buildPasswordField(),
                  isSignUp
                      ? !studentEnabled
                          ? _buildClassIDField()
                          : SizedBox(height: 10)
                      : SizedBox(
                          height: 20,
                        ),
                  isSignUp ? _buildChips() : SizedBox(),
                  isLoading
                      ? CircularProgressIndicator()
                      : _buildSubmitButton(),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isSignUp
                          ? Text('Already have an account ? ')
                          : Text('Sign up instead ? '),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              isSignUp = !isSignUp;
                            });
                          },
                          child: Text(
                            isSignUp ? 'SIGN IN' : 'SIGN UP',
                            style: TextStyle(color: ThemeConstants().blueColor),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
