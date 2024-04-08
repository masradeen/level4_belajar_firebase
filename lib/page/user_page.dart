import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});
  static const nameRoute = '/userpage';

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add User'),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 24,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24,),
            DateTimeField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Birthday',
              ),
              format: ,
            ),
          ],
        ),
      ),
    );
  }
}