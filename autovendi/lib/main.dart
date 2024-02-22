import 'package:autovendi/firebase_options.dart';
import 'package:autovendi/locations_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/Add_To_Wishlist_Bloc/AddToWishlist_bloc.dart';
import 'menu_view_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => ProductProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                AddToWishlistBloc()..add(const LoadAddToWishlistIcon())),
      ],
      child: MaterialApp(
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Color customGray = const Color(0xFFA9A9A9);
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/isoview.png',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'A.U.T.O.V.E.N.D.I.',
                      style: TextStyle(fontSize: 35, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome to Dynamic food delivery',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300, // Set the desired width
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Handle Google sign-in
                        },
                        icon: const Icon(Icons.mail),
                        label: const Text('Sign in with Google'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 195, 32, 20)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 300, // Set the desired width
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          String? result = await signInUser(
                              emailController.text, passwordController.text);
                          if (result == null) {
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LocationView()),
                            );
                          }
                        },
                        icon: const Icon(Icons.email),
                        label: const Text(
                          'Sign in with Email',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: customGray, // Use custom gray color
                          // minimumSize: Size(150, 30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300, // Set your desired width
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 300, // Set your desired width
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // Handle "Forgot your password?" action
                      },
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 150, // Set the desired width
                      child: ElevatedButton(
                        onPressed: () async {
                          // Handle email sign-in
                          String? result = await loginUser(
                              emailController.text, passwordController.text);
                          if (result == null) {
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LocationView()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: customGray, // Use custom gray color
                          // minimumSize: Size(150, 30),
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> signInUser(String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('error: ${e.toString()}');
      }
      return "Error";
    }
  }

  Future<String?> loginUser(String email, String password) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('error: ${e.toString()}');
      }
      return "Error";
    }
  }
}
