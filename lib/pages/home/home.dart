import 'package:flutter/material.dart';
import 'package:project/widgets/navbar_inside.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Directory current = Directory.current;

  void getCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('email')!);
    print(prefs.getString('password')!);
    emailController.text = prefs.getString('email')!;
    passwordController.text = prefs.getString('password')!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCredentials();
  }

  @override
  Widget build(BuildContext context) {
    String script = current.absolute.uri.toString() + "linked.py";
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          NavBar(),
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Text(
                          'The following credentials must be from your LinkedIn account')),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ButtonStyle(minimumSize:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Size(100, 40);
                              }
                              return Size(150, 40);
                            })),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                print(emailController.text.toString());
                                print(passwordController.text.toString());
                                print(script);
                                var result = await Process.run("python", [
                                  script,
                                  emailController.text.toString(),
                                  passwordController.text.toString(),
                                  "choice"
                                ]);
                                print(result.stdout);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill input')),
                                );
                              }
                            },
                            child: const Text('Start Process'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ButtonStyle(minimumSize:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Size(100, 40);
                              }
                              return Size(150, 40);
                            })),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                print(emailController.text.toString());
                                print(passwordController.text.toString());
                                print(script);

                                var result = await Process.run("python", [
                                  script,
                                  emailController.text.toString(),
                                  passwordController.text.toString(),
                                  "download"
                                ]);
                                print(result.stdout);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill input')),
                                );
                              }
                            },
                            child: const Text('Download Data'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ButtonStyle(minimumSize:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Size(100, 40);
                              }
                              return Size(150, 40);
                            })),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                print(emailController.text.toString());
                                print(passwordController.text.toString());
                                var result = await Process.run(
                                    "python", [script, "extract"]);
                                print(result.stdout);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill input')),
                                );
                              }
                            },
                            child: const Text('Extract File'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16.0),
                        child: Center(
                          child: ElevatedButton(
                            style: ButtonStyle(minimumSize:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Size(100, 40);
                              }
                              return Size(150, 40);
                            })),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                print(emailController.text.toString());
                                print(passwordController.text.toString());
                                print(script);
                                var result = await Process.run("python", [
                                  script,
                                  "update",
                                  emailController.text.toString()
                                ]);
                                print(result.stdout);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill input')),
                                );
                              }
                            },
                            child: const Text('Update Database'),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
