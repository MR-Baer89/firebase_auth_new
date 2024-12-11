import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
  String _userEmail = '';

  Future<void> _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: 'your_email@example.com', password: 'your_password');
      setState(() {
        _userEmail = _auth.currentUser!.email!;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    setState(() {
      _userEmail = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Auth Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_userEmail),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Einloggen'),
            ),
            ElevatedButton(
              onPressed: _signOut,
              child: const Text('Ausloggen'),
            ),
          ],
        ),
      ),
    );
  }
}
