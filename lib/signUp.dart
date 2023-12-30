import 'package:customizedcake/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                signUpUser(
                  _emailController.text,
                  _passwordController.text,
                  _firstNameController.text,
                  _lastNameController.text,
                  _addressController.text,
                );
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void signUpUser(String email, String password, String firstName, String lastName, String address) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.8/API/signup.php'), // Replace with your PHP script URL
      body: {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'address': address,
      },
    );

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('success')) {
          // Signup successful
          print("Signup successful: ${data['message']}");
          // Show a SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Signup successful!'),
            ),
          );
          // Navigate to another page (replace 'YourOtherPage' with the actual page you want to navigate to)
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
          // Navigate to the login page or any other page as needed
        } else if (data.containsKey('error')) {
          // Handle signup error
          print("Signup error: ${data['error']}");
          // Display an error message to the user
        }
      } catch (e) {
        // Print raw response for debugging
        print("Non-JSON Response: ${response.body}");
        print(e);
      }
    } else {
      // Handle HTTP request error
      print("HTTP request error. Status code: ${response.statusCode}");
      // Display an error message to the user
    }
  }
}
