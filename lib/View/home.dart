import 'dart:async';
import 'package:flutter/material.dart';
import '../Model/user.dart';
import '../Controller/userList.dart';
import 'Profile.dart';
import 'package:http/http.dart' as http;
import '../Controller/sharedDatabase.dart';
import '../Controller/manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    controlToLogin(context);
  }

  Future<void> controlToLogin(BuildContext context) async {
    await context.read(stateProvider).isLogined();
    if (context.read(stateProvider).isLogin) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 200, bottom: 0),
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () async{
                  context.read(stateProvider).emailValid(_email.text,_password.text);
                  if(context.read(stateProvider).checked){
                    await Login(_email.text, _password.text,context);
                    if(Manager.errors==""){
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    }else{
                      context.read(stateProvider).alert(context);
                    }
                  }else{
                    context.read(stateProvider).alert(context);
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}