import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/constants.dart';
import 'package:admin_panel/data/firebase/push.dart';
import 'package:admin_panel/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
        ChangeNotifierProvider(
            create: ((_) => FetchFireBaseData()),
            builder: (context,_) => MyApp(),
        ),
    // MyApp()
    //   DemoApp()
  );
}

// class DemoApp extends StatelessWidget {
//   DemoApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     pushit();
//     return Container(
//       child: Center(
//         child: Text(
//           'Hi',
//           textDirection: TextDirection.ltr,
//         ),
//       ),
//     );
//   }
//
//   Future<void> pushit() async {
//     push();
//   }
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        // providers: [
        //   ChangeNotifierProvider(
        //     create: (context) => MenuController(),
        //   ),
        // ],
        // child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home:
          // MultiProvider(
          //   providers: [
          //     ChangeNotifierProvider(
          //       create: (context) => MenuController(),
          //     ),
          //   ],
          //   child:
          MainScreen(),
      // ),
    );
  }
}
