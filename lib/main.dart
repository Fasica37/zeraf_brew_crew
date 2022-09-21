import 'package:flutter/services.dart';
import 'package:zeraf_brew_crew/screens/authenticate/authenticate.dart';
import 'package:zeraf_brew_crew/screens/home/home.dart';

import 'screens/wrapper.dart';
import 'services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/user.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
        routes: {
          Home.route: (context) => Home(),
          Authenticate.route: (context) => const Authenticate(),
        },
      ),
    );
  }
}
