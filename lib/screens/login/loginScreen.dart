import 'package:admin_panel/screens/login/google_login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.centerRight, end: Alignment.bottomLeft,
            //For Properties for Radial Gradient
            // radius: 3.5,
            //center: Alignment.topRight,
            // colors: [Colors.blueAccent, Colors.blue],
          // ),
        // ),
        child: Stack(children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Opacity(
                  opacity: .35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   // width: MediaQuery.of(context).size.width-100,
                      //   height: MediaQuery.of(context).size.height*.3,
                      // ),
                      Flexible(
                        flex: 5,
                        child: FaIcon(
                          FontAwesomeIcons.headSideVirus,
                          size: MediaQuery.of(context).size.width*.35,
                          color: Colors.white70,
                        ),
                      ),
                      // SizedBox(height: 20,),
                      Flexible(
                        flex: 1,
                        child: Text('Complete Mental Health Solution',
                          style: Theme.of(context).primaryTextTheme.headline1,
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
                // width: 500,
                child: GoogleSignUpButtonWidget()),
          )
        ]),
      ),
    );
  }
}
