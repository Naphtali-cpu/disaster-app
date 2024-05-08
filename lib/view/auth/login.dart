import 'package:disastermanagement/widgets/mytextfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../base/functions.dart';
import '../../widgets/mybutton.dart';
import '../../widgets/mytext.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  MyFunctions functions = MyFunctions();
  final email = TextEditingController();
  final password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 50),

            // welcome back, you've been missed!
            const Icon(
              Icons.account_circle,
              size: 100,
            ),

            const SizedBox(height: 50),

            const Center(
              child: MyTextView(
                data: 'Login',
                fontsize: 20,
                fontWeight: FontWeight.bold,
                maxlines: 1,
              ),
            ),

            const SizedBox(height: 10),
            MyTextField(hintstrin: 'Email', controller: email),
            const SizedBox(height: 10),

            // password textfield
            MyTextField(hintstrin: 'Password', controller: password,secure: true,),


            const SizedBox(height: 10),

            // forgot password?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap:(){
                      Navigator.pushNamed(context, '/dashboard');
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // sign in button
            MyButton(
                text: "Login",
                color: Colors.blue,
                function: () async {
                  if(email.text.isEmpty){

                  }else if(password.text.isEmpty){

                  }else{
                    EasyLoading.show(status: "Loading Please Wait");
                    await functions.loginUser(
                      context,
                      email.text,
                      password.text,
                    );
                  }

                }
            ),

            const SizedBox(height: 10),

            Center(
              child: InkWell(
                onTap:(){
                  Navigator.pushNamed(context, '/register');
                },
                child: MyTextView(
                  data: 'Not Registered? Register Here',
                  fontsize: 15,
                  fontWeight: FontWeight.w500,
                  maxlines: 1,
                ),
              ),
            ),

            const SizedBox(height: 50),

          ],
        ),
      ),
    );
  }
}
