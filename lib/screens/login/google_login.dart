import 'dart:async';

import 'package:admin_panel/backend/backend.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class GoogleSignUpButtonWidget extends StatefulWidget {
  @override
  _GoogleSignUpButtonWidgetState createState() =>
      _GoogleSignUpButtonWidgetState();
}

class _GoogleSignUpButtonWidgetState extends State<GoogleSignUpButtonWidget> {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            minimumSize: Size(300, 100),
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            side: BorderSide(color: Colors.black),
            backgroundColor: Colors.white70,
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              ColorTwinG(),
              SizedBox(width: 20,),
              Text(
                'Sign In With Google',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
          onPressed: () {
            final provider =
                Provider.of<FetchFireBaseData>(context, listen: false);
            provider.login();
          },
        ),
      );
}

class ColorTwinG extends StatefulWidget {
  const ColorTwinG({Key? key}) : super(key: key);

  @override
  _ColorTwinGState createState() => _ColorTwinGState();
}

class _ColorTwinGState extends State<ColorTwinG> {
  int colorVal = 0;
  Color color = Colors.red;
  Timer? _timer ;


  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 1000),_getColor);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      child: Padding(
        padding: EdgeInsets.all(colorVal%4),
        child: FaIcon(
          FontAwesomeIcons.google,
          color: color,
        ),
      ),
      duration: Duration(milliseconds: 300),
    );
  }

  void _getColor(Timer timer) {
    setState(() {
      int a = colorVal % 4;
      colorVal++;
      switch (a) {
        case 0:
          color = Colors.white70;
          break;
        case 1:
          color = Colors.red;
          break;
        case 2:
          color = Colors.green;
          break;
        default:
          color = Colors.orange;
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
