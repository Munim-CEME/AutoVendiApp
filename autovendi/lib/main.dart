import 'package:flutter/material.dart';

void main() {
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color customGray = Color(0xFFA9A9A9);
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/isoview.png', // Replace with your image asset
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                // color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'A.U.T.O.V.E.N.D.I.',
                    style: TextStyle(fontSize: 35, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Welcome to Dynamic food delivery',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300, // Set the desired width
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle Google sign-in
                      },
                      icon: Icon(Icons.mail),
                      label: Text('Sign in with Google'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 195, 32, 20)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 300, // Set the desired width
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle email sign-in
                      },
                      icon: Icon(Icons.email),
                      label: Text(
                        'Sign up with Email',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customGray, // Use custom gray color
                        // minimumSize: Size(150, 30),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 300, // Set your desired width
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 300, // Set your desired width
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Handle "Forgot your password?" action
                    },
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 150, // Set the desired width
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle login
                      },
                      child: Text(
                        'Log In',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customGray, // Use custom gray color
                        // minimumSize: Size(150, 30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
