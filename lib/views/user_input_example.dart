import 'package:flutter/material.dart';

class UserInputExample extends StatefulWidget {
  const UserInputExample({super.key});

  @override
  State<UserInputExample> createState() => _UserInputExampleState();
}

class _UserInputExampleState extends State<UserInputExample> {
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
      body: Padding(
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
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    print(emailController.text);
                    print(passwordController.text);
                    Navigator.pop(context);
                  }
                },
                child: Text("Submit Details"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
