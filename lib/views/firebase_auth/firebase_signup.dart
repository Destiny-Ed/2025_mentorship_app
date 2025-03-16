import 'package:flutter/material.dart';
import 'package:flutter_first_app/main.dart';
import 'package:flutter_first_app/providers/authentication_provider.dart';
import 'package:flutter_first_app/views/firebase_auth/firebase_login.dart';
import 'package:provider/provider.dart';

class FirebaseSignup extends StatefulWidget {
  const FirebaseSignup({super.key});

  @override
  State<FirebaseSignup> createState() => _FirebaseSignupState();
}

class _FirebaseSignupState extends State<FirebaseSignup> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up Screen'),
      ),
      body: Stack(
        children: [
          if (context.watch<AuthenticationProvider>().isLoading) Center(child: CircularProgressIndicator()),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) return "email is not valid";
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    validator: (value) {
                      if (value!.length < 6) return "password is too short";
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          child: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<AuthenticationProvider>(builder: (context, registerProvider, child) {
                    return ElevatedButton(
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await registerProvider.signUp(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          if (registerProvider.status && context.mounted) {
                            Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(builder: (context) => HomePage()), (_) => false);
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(registerProvider.message.toString()),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: Text("Sign up"),
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FirebaseLogin()));
                      },
                      child: Text("Already have an account? sign in"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
