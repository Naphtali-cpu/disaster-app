import 'dart:convert';

import 'package:disastermanagement/base/BaseData.dart';
import 'package:disastermanagement/base/SessionData.dart';
import 'package:disastermanagement/model/Disaster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Report.dart';
import '../model/UsersModel.dart';

class MyFunctions {
  BaseData baseData = BaseData();
  SessionData sessionData = SessionData();

  //Users Data
  registerUser(String email, String phone, String password) async {
    EasyLoading.show(status: "Registering, please wait");
    BaseData baseData = BaseData();
    Map map = <String, dynamic>{};
    map['email'] = email;
    map['phone'] = phone;
    map['password'] = password;
    var data = await baseData.postData('register', map);
    debugPrint('data');
    EasyLoading.dismiss();
  }

  loginUser(context, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    EasyLoading.show(status: "Logging in, please wait");
    BaseData baseData = BaseData();
    Map map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    var data = jsonDecode(await baseData.postData('login', map));
    debugPrint(data.toString());
    if (data.containsKey("token")) {
      await sessionData.userData(data);
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      EasyLoading.showError("Invalid Credentials");
    }
    EasyLoading.dismiss();
  }

  postReport(String description, String disaster, String source, String coordinates) async {
    EasyLoading.show(status: "Posting, please wait");
    BaseData baseData = BaseData();
    Map map = <String, dynamic>{};
    map['description'] = description;
    map['data'] = source;
    map['disaster'] = disaster;
    map['coordinates'] = coordinates;
    var data = await baseData.postData('post-report', map);
    debugPrint('data');
    EasyLoading.dismiss();
  }

  Future<List<Report>> fetchReports() async {
    var reportData = await baseData.getData('reports');
    final Map<String, dynamic> jsonData = jsonDecode(reportData);

    if (jsonData.containsKey('reports')) {
      final List<dynamic> jsonList = jsonData['reports'];

      List<Report> reportsList =
          jsonList.map((json) => Report.fromJson(json)).toList();
      return reportsList.reversed.toList();
    } else {
      return [];
    }
  }

  Future<List<Disaster>> getDisaster() async {
    var disasterData = await baseData.getData('disaster');
    final Map<String, dynamic> jsonData = jsonDecode(disasterData);

    if (jsonData.containsKey('disaster')) {
      final List<dynamic> jsonList = jsonData['disaster'];

      List<Disaster> disasterList =
      jsonList.map((json) => Disaster.fromJson(json)).toList();
      return disasterList.reversed.toList();
    } else {
      return [];
    }
  }
}
