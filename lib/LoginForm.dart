import 'package:customizedcake/signUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
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
  GlobalKey<FormState> _frmkey = GlobalKey();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('background_image.jpg'),
        fit: BoxFit.cover,
    ),
    ),
    child: Center(
    child: Container(
      padding: EdgeInsets.all(40.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Set the shadow color
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // Offset of the shadow
          ),
        ],
      ),
      constraints: BoxConstraints(maxWidth: 350.0,maxHeight: 450.0),
      child: Form(
        key: _frmkey,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Login", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          SizedBox(height: 40,),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
              ),
              hintText: 'enter your email',
            ),
            keyboardType: TextInputType.emailAddress, // Set the keyboard type to email
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$'),
              ),
            ],
            validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
              return null;
            },
          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                child: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              hintText: 'enter your email',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          Row(
              children:[
                SizedBox(width: 180,),
                ElevatedButton(
                  onPressed: () {
                    authenticateUser(context, _emailController.text, _passwordController.text);
                  },
                  child: Text('Login'),
                ),
              ],
          ),
          SizedBox(height: 20),
          Row(
              children:[
                Text("Don't have an account yet? ",style: TextStyle(fontSize: 12)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text('Signup',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontSize: 12,
            ),
                ),
                ),
              ]
          ),
        ],
      ),
    )
    )

    )
    );
  }
}
// The rest of your authentication logic remains unchanged


void authenticateUser(BuildContext context, String email, String password) async {
  final response = await http.post(
    Uri.parse('http://192.168.1.8/API/login.php'), // Replace with your PHP script URL
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
