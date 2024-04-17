import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:level4_belajar_firebase/models/user_model.dart';
import 'package:level4_belajar_firebase/page/home_page.dart';
import 'package:level4_belajar_firebase/page/user_page.dart';

// void main() {
//   runApp(const MyApp());
// }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      initialRoute: HomePage.nameRoute,
      routes: {
        UserPage.nameRoute: (context) => UserPage(),
        HomePage.nameRoute: (context) => HomePage(),
      },
      // Scaffold(
      //   appBar: AppBar(
      //     // title: TextField(controller: controller),
      //     title: Text('User App Firebase'),
      //     actions: [
      //       IconButton(
      //         icon: Icon(Icons.add),
      //         onPressed: () {
      //           // final name = controller.text;
      //           // createUser(name: name);
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => const UserPage()),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  // Future createUser({required String name}) async {
  //   // reference to document
  //   // final docUser = FirebaseFirestore.instance.collection('users').doc('my_id');

  //   //generate id automatically
  //   final docUser = FirebaseFirestore.instance.collection('users').doc();

  //   // final json = {
  //   //   'name': name,
  //   //   'age': 21,
  //   //   'birthday': DateTime(2001, 7, 28),
  //   // };

  //   // using model
  //   final user = User(
  //     id: docUser.id,
  //     name: name,
  //     age: 21,
  //     birthday: DateTime(2001, 7, 28),
  //   );

  //   final json = user.toJson();

  //   // create document and write data to Firebase
  //   await docUser.set(json);
  // }
}
