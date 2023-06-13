import 'package:provider/provider.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogorideapp/pages/register.dart';

import '../services/authProvider.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: SingleChildScrollView(
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
                      hintText: 'email',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                      hintText: 'password',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
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
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password is too short';
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
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                            (route) => false,
                      );
                    },
                    child: Text(
                      'No account ? Register',
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
                        if (_formKey.currentState!.validate()) {
                          authProvider.signInWithEmailAndPassword(
                            _email.trim(),
                            _password.trim(),
                            context,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      },
                      child: Text('Login',

                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20


                        ),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}