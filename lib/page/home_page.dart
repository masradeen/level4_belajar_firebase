import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:level4_belajar_firebase/models/user_model.dart';
import 'package:level4_belajar_firebase/page/user_page.dart';

class HomePage extends StatefulWidget {
  static const nameRoute = './homepage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // title: TextField(controller: controller),
          title: Text('All Users'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(UserPage.nameRoute);
              },
            ),
          ],
        ),
        body:
            //to get a single user
            Column(
          children: [
            FutureBuilder<User?>(
              future: readUser(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final user = snapshot.data;

                  return user == null
                      ? Center(child: Text('No User'))
                      : buildUser(user);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 32,),
            ElevatedButton(
              child: Text('Update'),
              onPressed: () {
                final docUser = FirebaseFirestore.instance
                    .collection('users')
                    .doc('sTWpJYdOySZxhyjPDxYZ');

                //update spesific fields
                docUser.update({
                  'name': 'Sigit Nugroho',
                });
              },
            ),
            const SizedBox(height: 32,),
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                final docUser = FirebaseFirestore.instance
                    .collection('users')
                    .doc('sTWpJYdOySZxhyjPDxYZ');

                //update spesific fields
                docUser.delete();
              },
            ),

          ],
        ),

        //FutureBuilder -> need to restart the app to get the update
        /*  FutureBuilder(
          stream: readUsers().first,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;

              return ListView(
                children: users.map(buildUser).toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ), */
        //StreamBuilder -> automatically(real time) change the value on the UI when the data changed
        /*  StreamBuilder(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;

              return ListView(
                children: users.map(buildUser).toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ), */
      ),
    );
  }

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(
          child: Text('${user.age}'),
        ),
        title: Text(user.name),
        subtitle: Text(user.birthday.toIso8601String()),
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  Future<User?> readUser() async {
    //get single doc by ID
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc('sTWpJYdOySZxhyjPDxYZ');
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
  }

  Future createUser({required String name}) async {
    // reference to document
    // final docUser = FirebaseFirestore.instance.collection('users').doc('my_id');

    //generate id automatically
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    // final json = {
    //   'name': name,
    //   'age': 21,
    //   'birthday': DateTime(2001, 7, 28),
    // };

    // using model
    final user = User(
      id: docUser.id,
      name: name,
      age: 21,
      birthday: DateTime(2001, 7, 28),
    );

    final json = user.toJson();

    // create document and write data to Firebase
    await docUser.set(json);
  }
}
