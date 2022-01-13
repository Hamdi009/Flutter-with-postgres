import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:postgres/postgres.dart';

class Home extends StatelessWidget {
  final String name;

  Home(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText('Welcome Home ' + name,
                    textStyle: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    speed: const Duration(milliseconds: 500)),
              ],
            ),

            // const SizedBox(
            //   height: 20,
            // ),

            const SizedBox(
              height: 30,
            ),

            Padding(
              padding: EdgeInsets.only(top: 8, right: 8, left: 8),
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
