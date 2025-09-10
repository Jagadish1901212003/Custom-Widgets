import 'dart:convert';
import 'package:custom_widgets/utility/share_singleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefCommon {
  // static String REFERESH_TOKEN = "refreshtoken";
  static String LOGIN_USER_DETAILS = 'LOGIN_USER_DETAILS';
  static String LOGGED_IN = "LOGGED_IN";
  static String LOCAL_DB_DATA_INFO = "LOCAL_DB_DATA_INFO";
  static const String ACCESS_TOKEN = "ACCESS_TOKEN";

  static Future<void> clearAllPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(ACCESS_TOKEN);
    prefs.remove(LOGGED_IN);

    prefs.remove(LOGIN_USER_DETAILS);
    SharedSingleton.shared.apiAccessToken = "";
    SharedSingleton.shared.accessToken = "";
    SharedSingleton.shared.loginUserId = "";
    SharedSingleton.shared.loginUserName = "";
    //clearLocalDBPreferences();
  }

  //newly added

  static Future<void> clearLocalDBPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(LOCAL_DB_DATA_INFO);
  }

  static setLocalDBDetails(Map userobj) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LOCAL_DB_DATA_INFO, jsonEncode(userobj));
    return true;
  }

  static getLocalDBDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(LOCAL_DB_DATA_INFO);
    if (data != null) {
      return json.decode(data);
    } else {
      return null;
    }
  }

  //temp

  static getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(ACCESS_TOKEN);
  }

  static setAccessToken(String accessTocken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ACCESS_TOKEN, accessTocken);
    return true;
  }

  static setUserDetails(Map userobj) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LOGIN_USER_DETAILS, jsonEncode(userobj));
    return true;
  }

  static getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(LOGIN_USER_DETAILS);
    if (data != null) {
      return json.decode(data);
    } else {
      return null;
    }
  }

  static setIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LOGGED_IN, true);
    return true;
  }

  static Future<bool> getIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(LOGGED_IN) ?? false;
  }
}
