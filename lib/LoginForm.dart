import 'package:customizedcake/signUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:customizedcake/AdminPanel.dart';
import 'package:customizedcake/HomeScreen.dart';
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Login", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              authenticateUser(context, _emailController.text, _passwordController.text);
            },
            child: Text('Login'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Navigate to the signup screen or perform signup logic
              // For simplicity, let's assume you have a SignupScreen widget
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupPage()),
              );
            },
            child: Text('Signup'),
          ),
        ],
      ),
    );
  }
}
// The rest of your authentication logic remains unchanged


void authenticateUser(BuildContext context, String email, String password) async {
  final response = await http.post(
    Uri.parse('http://10.0.0.15/API/login.php'), // Replace with your PHP script URL
    body: {
      'email': email,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    try {
    final Map<String, dynamic> data = json.decode(response.body);
    if (data.containsKey('role')) {
      int? role = int.tryParse(data['role']);
      // Navigate to AdminPanel or HomeScreen based on the role
      if (role == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPanel()),
        ); // Navigate to AdminPanel
      } else if (role == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        ); // Navigate to HomeScreen
      }
    } else if (data.containsKey('error')) {
      // Handle authentication error
      print("Authentication error: ${data['error']}");
    }
    } catch (e) {
      // Print raw response for debugging
      print("Non-JSON Response: ${response.body}");
      print(e);
    }
  } else {
    // Handle HTTP request error
    print("HTTP request error. Status code: ${response.statusCode}");
  }
}
