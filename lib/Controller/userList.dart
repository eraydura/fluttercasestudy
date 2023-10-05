import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/user.dart';
import 'manager.dart';
import '../Model/UserList.dart';
import 'package:flutter/foundation.dart';
import 'sharedDatabase.dart';
import 'manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


Future<List<UserList>> fetchUser(http.Client client,context) async {
  final id=await AppCache.UserId();
  final response = await client.get(Uri.parse('https://reqres.in/api/users?pages=2'));
  if (response.statusCode == 200) {
    return compute(parseUsers, response.body);
  }else{
    Manager.loginerror('Can not connect to the server');
    throw 'Can not connect to the server';
  }
}

List<UserList> parseUsers(String responseBody) {
  final parsed = jsonDecode(responseBody)["data"].cast<Map<String, dynamic>>();
  return parsed.map<UserList>((json) => UserList.fromJson(json)).toList();
}

Future<UserList> fetchUser2(http.Client client) async {
  final id=await AppCache.UserId();
  final response = await client.get(Uri.parse('https://reqres.in/api/users/'+id.toString()));
  if (response.statusCode == 200) {
    return compute(parseUsers2, response.body);
  }else{
    Manager.loginerror('Can not connect to the server');
    throw 'Can not connect to the server';
  }
}

UserList parseUsers2(String responseBody) {
  final parsed = jsonDecode(responseBody)["data"];
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = parsed["id"];
  data['first_name'] = parsed["first_name"];
  data['last_name'] = parsed["last_name"];
  data['email'] = parsed["email"];
  data['avatar'] = parsed["avatar"];
  final user= new UserList.fromJson(data);
  return user;
}




Future<void> Login(String? email, String? password,context) async{

  final response = await http.post(
    Uri.parse('https://reqres.in/api/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "email": email! as String,
      "password": password! as String
    }),
  );

  if (response.statusCode == 200) {
    await AppCache.cacheToken(User.fromJson(jsonDecode(response.body)).token.toString());
    await AppCache.cacheId(User.fromJson(jsonDecode(response.body)).id ?? 0);
    await User.fromJson(jsonDecode(response.body));
  }else if(response.statusCode == 400){
    Manager.loginerror('Only defined users succeed login');
  } else {
    Manager.loginerror('Can not connect to the server');
  }

}


