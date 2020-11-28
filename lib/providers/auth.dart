import 'package:TestGround/models/httpexception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Authenticator with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  bool isUserLogged = false;

  bool get isAuth {
    // print(_token);
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> signUpWithdetails(Map details, {String password}) async {
    // print(details);
    final email = details['emailId'];
    final passwordfunc = password;

    final signUpUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDBdUynJ1OheBS6g7uwph4szbScy2AzcEA';

    try {
      final signUpResponse = await http.post(
        signUpUrl,
        body: json.encode(
          {
            "email": email,
            "password": passwordfunc,
            "returnSecureToken": true,
          },
        ),
      );
      final responseData = json.decode(signUpResponse.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken']; //get id token of user
      _userId = responseData['localId'];

      final dataUrl =
          'https://ayachi-academy.firebaseio.com/users/$_userId.json';

      try {
        final userAddResponse =
            await http.put(dataUrl, body: json.encode(details));
      } catch (err) {
        throw err;
      }

      //get user id
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
      // print('Token :  $_token');
      // print(_userId);
      // print(_expiryDate);
    } catch (err) {
      // print(err);
      throw err;
    }
  }

  Future<void> storeUserInfoInSharedPref(String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('email', email);
    preferences.setString('password', password);
    preferences.setBool('isUserLoggedIn', true);
    // preferences.setBool('isUserLoggedIn', true);
    isUserLogged = preferences.getBool('isUserLoggedIn');
    // print(preferences.getString('email'));
    // print(preferences.getString('password'));
    print('is user logged $isUserLogged');

    // Map details = {'emailId': email};
    // if (isUserLogged) {
    //   signIn(details, password: password);
    // }
    notifyListeners();
  }

  Future<void> signInFromSF(String email, String password) async {
    final signUpUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDBdUynJ1OheBS6g7uwph4szbScy2AzcEA';
    try {
      final signUpResponse = await http.post(
        signUpUrl,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      final responseData = json.decode(signUpResponse.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken']; //get id token of user
      _userId = responseData['localId']; //get user id
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      print(_userId);
      notifyListeners();
    } catch (err) {
      // print(err);
      throw err;
    }
    // notifyListeners();
  }

  Future<void> checker() async {
    print('called');
    
  }

  Future<void> signIn(Map details, {String password}) async {
    // print(details);
    final email = details['emailId'];
    final passwordfunc = password;

    const dataUrl = 'https://ayachi-academy.firebaseio.com/users.json';
    final signUpUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDBdUynJ1OheBS6g7uwph4szbScy2AzcEA';
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final signUpResponse = await http.post(
        signUpUrl,
        body: json.encode(
          {
            "email": email,
            "password": passwordfunc,
            "returnSecureToken": true,
          },
        ),
      );
      final responseData = json.decode(signUpResponse.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken']; //get id token of user
      _userId = responseData['localId']; //get user id
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      // print(preferences.getBool('isUserLoggedIn'));
      // if (!preferences.getBool('isUserLoggedIn')) {
      //   storeUserInfoInSharedPref(email, password);
      // }
      print('called');
      notifyListeners();
      // print('Token :  $_token');
      // print(_userId);
      // print(_expiryDate);
    } catch (err) {
      // print(err);
      throw err;
    }
  }
}

//API KEY : AIzaSyDBdUynJ1OheBS6g7uwph4szbScy2AzcEA
