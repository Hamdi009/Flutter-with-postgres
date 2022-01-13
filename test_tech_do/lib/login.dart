import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:postgres/postgres.dart';
import 'package:postgrest/postgrest.dart';
import 'package:test_tech_do/home.dart';

class login extends StatelessWidget {
  login({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String name = "";
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
                TyperAnimatedText('Login',
                    textStyle: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    speed: const Duration(milliseconds: 500)),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(left: 70, right: 70, top: 70),
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
                obscureText: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                bool exist = false;
                final String email_ = emailController.text.trim();
                final String pass = passController.text.trim();
                var connection = PostgreSQLConnection(
                    "10.0.2.2", 5433, "flutterInfo",
                    username: "postgres", password: "root");
                await connection.open();
                List<Map<String, Map<String, dynamic>>> result =
                    await connection.mappedResultsQuery(
                        "SELECT email,password,name from public.\"userInfo\" ");
                print(result);
                result.forEach((element) {
                  var e = element["userInfo"]!["email"];
                  var p = element["userInfo"]!["password"];
                  var n = element["userInfo"]!["name"];
                  if (email_ == e && pass == p) {
                    exist = true;
                    name = n;
                    //print("exist");
                  }

                  print("n = " + n + " p = " + p);
                });
                if (exist) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Home(name)));
                  print("redirect");
                }

                // for (final row in result) {
                //   //var mm = row["email"];
                //   print(row['email']);
                // }
                // ***********
                // var url = 'localhost:5433/flutterInfo';
                // var client = PostgrestClient(url);
                // var response = await client
                //     .from("public.\"userInfo\"")
                //     .select("email")
                //     .execute();
                // print(response);
              },
              child: const Text(
                "Login",
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
