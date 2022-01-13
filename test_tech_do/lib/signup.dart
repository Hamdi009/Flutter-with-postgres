import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:postgres/postgres.dart';
import 'package:postgrest/postgrest.dart';

class signUp extends StatefulWidget {
  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  // Future connection() async {
  //   var connection = PostgreSQLConnection("10.0.2.2", 5433, "flutterInfo",
  //       username: "postgres", password: "root");
  //   await connection.open();
  //   var results = await connection.query(
  //       "INSERT INTO public.\"userInfo\"(name,email,password) values ('nameController','test','test')");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText('Sign up',
                    textStyle: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    speed: const Duration(milliseconds: 500)),
              ],
            ),
            // const SizedBox(
            //   height: 30,
            // ),
            Padding(
              padding: EdgeInsets.only(left: 70, right: 70, top: 30),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Your name'),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: EdgeInsets.only(left: 70, right: 70, top: 08),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Your Email'),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: EdgeInsets.only(left: 70, right: 70, top: 08),
              child: TextFormField(
                controller: passController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                final String name_ = nameController.text.trim();
                final String email_ = emailController.text.trim();
                final String pass = passController.text.trim();
                var connection = PostgreSQLConnection(
                    "10.0.2.2", 5433, "flutterInfo",
                    username: "postgres", password: "root");
                await connection.open();
                var results = await connection.query(
                    "INSERT INTO public.\"userInfo\" (name,email,password) VALUES (@name:text,@email:text,@password:text) ",
                    substitutionValues: {
                      "name": name_,
                      "email": email_,
                      "password": pass
                    });
                //connection();

                // var url = 'localhost/5432';
                // var client = PostgrestClient(url);
                // var response = await client.from('userInfo').insert([
                //   {'name': 'name_', 'email': 'email_', 'password': 'pass_'}
                // ]).execute();
                print('save signup');
              },
              child: const Text(
                "Sign up",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
