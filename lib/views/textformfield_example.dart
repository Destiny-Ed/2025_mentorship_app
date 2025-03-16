import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextformfieldExample extends StatefulWidget {
  const TextformfieldExample({super.key});

  @override
  State<TextformfieldExample> createState() => _TextformfieldExampleState();
}

class _TextformfieldExampleState extends State<TextformfieldExample> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _fullnameFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  bool _isObscured = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Semantics(
                    label: "enter your name",
                    child: TextFormField(
                      focusNode: _fullnameFocus,
                      controller: fullNameController,
                      textInputAction: TextInputAction.next,
                      maxLength: 10,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      autofocus: true,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Full name',
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.blue),
                      ),
                      cursorColor: Colors.green,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Full name is required';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_emailFocus);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Semantics(
                    label: "enter your email address",
                    child: TextFormField(
                      focusNode: _emailFocus,
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      cursorColor: Colors.green,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'email is required';
                        }
                        if (!value.contains('@')) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_passwordFocus);
                      },
                      decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Semantics(
                    label: "Enter your phone number",
                    child: TextFormField(
                      controller: phoneNumberController,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.green,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'number is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Phone number', border: OutlineInputBorder()),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Semantics(
                    label: "Enter your secured password",
                    child: TextFormField(
                      focusNode: _passwordFocus,
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      obscureText: _isObscured,
                      cursorColor: Colors.green,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'password is required';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Semantics(
                    label: "Submit form",
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form submitted successfully
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Form submitted successfully'),
                            ),
                          );
                        }
                      },
                      child: Text("Submit"),
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
