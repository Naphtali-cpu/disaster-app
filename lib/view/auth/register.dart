import 'package:disastermanagement/base/functions.dart';
import 'package:disastermanagement/widgets/mybutton.dart';
import 'package:disastermanagement/widgets/mytext.dart';
import 'package:disastermanagement/widgets/mytextfields.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();

}

class _RegisterScreenState extends State<RegisterScreen> {


  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  void registerUser(String email, String phone, String password) async {
    MyFunctions functions = MyFunctions();
    await functions.registerUser(
      email,
      phone,
      password,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.account_circle,
                size: 100,
              ),

              const SizedBox(height: 50),

              const Center(
                child: MyTextView(
                  data: 'Register for Disasty',
                  fontsize: 20,
                  fontWeight: FontWeight.bold,
                  maxlines: 1,
                ),
              ),

              const SizedBox(height: 10),
              MyTextField(hintstrin: 'Email', controller: email),

              const SizedBox(height: 10),
              MyTextField(hintstrin: 'Phone', controller: phone),

              const SizedBox(height: 10),
              MyTextField(hintstrin: 'Password', controller: password,secure: true,),
              // password textfield


              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                  text: "Register",
                  color: Colors.blue,
                  function: () async {
                    registerUser(email.text, phone.text, password.text);
                  }
              ),

              const SizedBox(height: 50),

              // Section for not a member? register now text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MyTextView(
                    data: 'Already a member?',
                    fontsize: 15,
                    fontWeight: FontWeight.bold,
                    maxlines: 1,
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the Login page here
                      Navigator.popAndPushNamed(context, '/login');
                    },
                    child: const MyTextView(
                      data: 'Login Now',
                      fontsize: 13,
                      fontWeight: FontWeight.bold,
                      maxlines: 1,
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
