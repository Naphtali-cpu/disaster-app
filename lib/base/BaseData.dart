import 'dart:convert';

import 'package:disastermanagement/base/SessionData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BaseData{
  String baseurl = "https://emergiency-response.titan.africa/";
  List<String> incomes = ['Fixed','Allowance','Extra'];

  Future<String> getData(String url) async{
    Map<String, String> requestHeaders = await custonheaders();
    if (kDebugMode) {
      print('${baseurl}api/$url');
    }
    try{
      Response response = await get(Uri.parse('${baseurl}api/$url'),headers: requestHeaders);
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        const data = {'status':'failed','response':'Failed to connect to server'};
        return jsonEncode(data);
      }
    }on Exception catch(e){
      EasyLoading.dismiss();
      EasyLoading.showError("Failed to connect");
      return "0";
    }

  }

  Future<String> postData(String url,map) async{
    Map<String, String> requestHeaders = await custonheaders();
    debugPrint('${baseurl}api/$url');
    try{
      Response response = await post(Uri.parse('${baseurl}api/$url'),body: jsonEncode(map),headers: requestHeaders);
      if (kDebugMode) {
        print('response ${response.body}');
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print(response.body);
        }
        return response.body;
      } else {
        if (kDebugMode) {
          print("server response : ${response.statusCode}");
        }
        const data = {'status':'failed','response':'Failed to connect to server'};
        return jsonEncode(data);
      }
    }on Exception catch(e){
      EasyLoading.dismiss();
      EasyLoading.showError("Failed to connect");
      return "0";
    }

  }

  custonheaders() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    SessionData sessionData = SessionData();
    String? token = prefs.getString(sessionData.token);
    debugPrint(token);
    Map<String, String> requestHeaders = {};
    if(token != null){
      requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
    }else{
      requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      };
    }

    return requestHeaders;
  }


  bool comparestring(String s1,String s2){
    if(s1.toLowerCase() == s2.toLowerCase()){
      return true;
    }else{
      return false;
    }
  }

}