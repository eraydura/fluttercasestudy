import 'dart:async';
import 'package:flutter/material.dart';
import '../Model/UserList.dart';
import '../Controller/userList.dart';
import 'List.dart';
import 'package:http/http.dart' as http;
import '../Controller/sharedDatabase.dart';
import '../Controller/manager.dart';
import 'home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await context.read(stateProvider).signout();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        },
        child: const Icon(Icons.exit_to_app),
      ),
      body: Padding(
        child: FutureBuilder<UserList>(
          future: fetchUser2(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? ProfilePage(user: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
        padding: EdgeInsets.fromLTRB(1.0, 10.0, 1.0, 10.0),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final UserList? user;

  ProfilePage({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
            Container(
                color: Colors.white10,
                alignment: Alignment.center,
                child: Column(
                  children:[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        user!.avatar!,
                        height: 300.0,
                        width: 300.0,
                      ),
                    ),
                    Text(user!.first_name!+" "+ user!.last_name!, style:TextStyle(fontSize:30)),
                  ]
                )
            ),
            SizedBox(height:150),
            Container(
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    onSurface: Colors.red,
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Lists()),
                    );
                  },
                  child: Text('All User Lists',style:TextStyle(fontSize:20)),
                ),
            ),
          ],
        );
  }
}