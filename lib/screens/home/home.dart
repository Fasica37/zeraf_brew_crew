import 'package:zeraf_brew_crew/screens/authenticate/authenticate.dart';

import '../../models/brew.dart';
import '../../models/user.dart';
import 'brew_list.dart';
import 'settings_form.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Home({Key? key}) : super(key: key);
  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: const SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService(uid: user?.uid).brews,
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              icon: const Icon(Icons.person),
              label: const Text('logout'),
              onPressed: () async {
                await _auth.signOut();
                Navigator.of(context).pushReplacementNamed(Authenticate.route);
              },
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              icon: const Icon(Icons.settings),
              label: const Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const BrewList()),
      ),
    );
  }
}
