import 'package:shared_preferences/shared_preferences.dart';
class SessionData{
  String name = "name";
  String password = "password";
  String token = "token";
  String email = "email";
  String phone = "phone";


  String items = "items";

  userData(response)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, response['user']['name']);
    await prefs.setString(email, response['user']['email']);
    await prefs.setString(token, response['token']);
  }

  //location data
  String mycounty = "mycounty";
  String mysubcounty = "mycounty";
  String mylatlong = "mycounty";
  //save county
  void saveMyCounty(data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(mycounty, data);
  }

  //save my subcounty
  void saveMysubcounty(data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(mysubcounty, data);
  }

  void saveMyLatlong(data) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(mylatlong, data);
  }


}