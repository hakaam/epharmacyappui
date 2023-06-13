
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogorideapp/pages/signin.dart';

import '../services/authProvider.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSLhGWFMpQLO0R8I0JLIU-ww65FSBg2uwcDasCfWegnA&s'),
                  SizedBox(height: 20),
                  TextFormField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    validator: ((value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email address';
                      }
                      return null;
                    }),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: authProvider.obscureText, // Use obscureText property
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                        size: 20,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          authProvider.togglePasswordVisibility(); // Toggle password visibility
                        },
                        child: Icon(
                          authProvider.obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                    validator: ((value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password is too short';
                      }
                      return null;
                    }),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    enableSuggestions: true,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (value) {
                      _password = value;
                    },
                    obscureText: authProvider.obscureText, // Use obscureText property
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value != _password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    thickness: 2,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Already have an account? Sign In',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue


                      ),
                      onPressed: () {
                        authProvider.signUpWithEmailAndPassword(
                          _email.trim(),
                          _password.trim(),
                          context,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignIn()),
                        );
                      },
                      child: Text('Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20


                        ),

                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
