// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_application/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

import '../config/config.dart';
import '../db/db_service.dart';

class UserProvider extends ChangeNotifier {
  int _statusCode = 0;
  String _message = "";

  get statusCode => _statusCode;
  set statusCode(value) => _statusCode = value;

  get message => _message;
  set message(value) => _message = value;

  Future<void> login(String username, String password) async {
    final url = Uri.parse('${Configs.baseUrl}/Invoke');

    final requestBody = json.encode({
      "API_Body": [
        {
          "Unique_Id": "",
          "Pw": password,
        }
      ],
      "Api_Action": "GetUserData",
      "Company_Code": username,
    });

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': "application/json",
          'Accept': "application/json",
        },
        body: requestBody,
      );
      final responseData = json.decode(response.body);

      if ((responseData['Response_Body'][0]['User_Code'] == null) ||
          (responseData['Response_Body'][0]['Doc_Msg'] == "Invalid Password")) {
        throw Exception("Invalid credentials");
      }

      statusCode = responseData['Status_Code'];
      message = responseData['Message'];
      final responseBody = responseData['Response_Body'];

      final user = responseBody[0];
      UserModel(
        user['User_Code'],
        user['User_Display_Name'],
        user['Email'],
        user['User_Employee_Code'],
        user['Company_Code'],
        user['User_Locations'].cast<String>(),
        user['User_Permissions'].cast<String>(),
      );

      final db = await DBService().db;

      await db.insert(
        'users',
        {
          'usercode': user['User_Code'],
          'userName': user['User_Display_Name'],
          'userEmail': user['Email'],
          'userEmpCode': user['User_Employee_Code'],
          'companyCode': user['Company_Code'],
          'created_at': DateTime.now().millisecondsSinceEpoch,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      List<Map<String, dynamic>> allUsers = await db.query('users');
      print('All users in the database: $allUsers');
    } catch (error) {
      print('An error occurred: $error');
      rethrow;
    }
  }
}
