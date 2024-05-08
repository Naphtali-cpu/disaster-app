import 'package:disastermanagement/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
class MyAlerts{

  warningAlert(context, String item, Function function, Function ondismiss) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Warning",
      desc: "Are you sure you want to delete $item",
      closeFunction: ondismiss(),
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
            function();
          },
          color: Colors.red,
          child: MyTextView(
            data: "Delete",
            colors: Colors.white,
          ),
        ),
        DialogButton(
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
          child: MyTextView(
            data: "Cancel",
            colors: Colors.white,
          ),
        )
      ],
    ).show();
  }

  logoutAlert(context,Function function) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Logout",
      desc: "Are you sure you want to Logout...?",
      buttons: [
        DialogButton(
          onPressed: () {
            function();
            Navigator.pop(context);
          },
          color: Colors.red,
          child: const MyTextView(
            data: "Logout",
            colors: Colors.white,
          ),
        ),
        DialogButton(
          onPressed: (){
            Navigator.pop(context);
          },
          gradient: const LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
          child: const MyTextView(
            data: "Cancel",
            colors: Colors.white,
          ),
        )
      ],
    ).show();
  }
}