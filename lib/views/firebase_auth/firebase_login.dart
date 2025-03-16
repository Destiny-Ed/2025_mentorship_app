import 'package:flutter/material.dart';
import 'package:flutter_first_app/main.dart';
import 'package:flutter_first_app/providers/authentication_provider.dart';
import 'package:flutter_first_app/views/firebase_auth/firebase_signup.dart';
import 'package:provider/provider.dart';

class FirebaseLogin extends StatefulWidget {
  const FirebaseLogin({super.key});

  @override
  State<FirebaseLogin> createState() => _FirebaseLoginState();
}

class _FirebaseLoginState extends State<FirebaseLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Consumer<AuthenticationProvider>(builder: (context, loginProvider, child) {
        return Stack(
          children: [
            if (loginProvider.isLoading) Center(child: CircularProgressIndicator()),
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
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await loginProvider.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          if (loginProvider.status && context.mounted) {
                            Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(builder: (context) => HomePage()), (_) => false);
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(loginProvider.message.toString()),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: Text("Log in"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FirebaseSignup()));
                        },
                        child: Text("Don't have an account? sign up")),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                      onPressed: () async {
                        await loginProvider.googleAuth();
                        if (loginProvider.status && context.mounted) {
                          Navigator.pushAndRemoveUntil(
                              context, MaterialPageRoute(builder: (context) => HomePage()), (_) => false);
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(loginProvider.message.toString()),
                              ),
                            );
                          }
                        } //android
                      },
                      child: Text("Google sign in"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
