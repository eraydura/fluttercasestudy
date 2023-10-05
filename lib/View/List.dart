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

class Lists extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main List"),
      ),
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
        child: FutureBuilder<List<UserList>>(
          future: fetchUser(http.Client(),context),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? Userlist(users: snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
        padding: EdgeInsets.fromLTRB(1.0, 10.0, 1.0, 10.0),
      ),
    );
  }
}

class Userlist extends StatelessWidget {
  final List<UserList>? users;

  Userlist({Key? key, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users!.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Container(
                color: Colors.white10,
                alignment: Alignment.center,
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Image.network(
                          users![index].avatar!,
                          fit: BoxFit.fitWidth,
                        ),
                        title: Text(users![index].first_name!),
                        subtitle: Text(users![index].last_name!),
                      ),
                    ],
                  ),
                )),
          ],
        );
      },
    );
  }
}