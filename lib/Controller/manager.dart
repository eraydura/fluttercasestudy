import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sharedDatabase.dart';
import 'package:flutter/material.dart';

class Manager {
  manager() {
    isLogined();
  }

  bool isLogin = false;
  bool checked = false;
  static String errors = "";

  Future<void> isLogined() async {
    final token = await AppCache.UserToken();
    if (token != null && token!="") {
      isLogin = true;
    }
  }

  Future<void> signout() async{
    await AppCache.removeAll();
    isLogin = false;
  }

  void emailValid (email,password){
    errors="";
    checked=false;
    bool emailvalid=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if(email.isEmpty && password.isEmpty){
        errors="Email or Password can not be empty";
    }else if(!emailvalid){
        errors="Email is not valid";
    }else{
      checked=true;
    }
  }

  static void loginerror(error){
    errors="";
    errors=error;
  }

  alert(context){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errors),
            actions: <Widget>[
              TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

}

final stateProvider = Provider((ref) => Manager());