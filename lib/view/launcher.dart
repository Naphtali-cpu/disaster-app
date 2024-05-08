import 'package:disastermanagement/base/SessionData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Launcher extends StatefulWidget {
  const Launcher({super.key});

  @override
  State<Launcher> createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  SessionData sessionData = SessionData();
  start()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Future.delayed(const Duration(microseconds: 4000), () {
      if(preferences.containsKey(sessionData.token)){
        Navigator.popAndPushNamed(context, '/dashboard');
      }else{
        Navigator.popAndPushNamed(context, '/login');
      }

    });
  }
  @override
  void initState() {
    start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 500,
        ),
      ),
    );
  }
}
