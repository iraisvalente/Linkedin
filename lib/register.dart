import 'package:flutter/material.dart';
import 'package:project/db/sqlite_service.dart';
import 'package:project/home.dart';
import 'package:project/models/user.dart';
import 'package:project/navbar_init.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // text controllers
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // sqlite
  late SqliteService _sqliteService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sqliteService = SqliteService();
  }

  @override
  Widget build(BuildContext context) {
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: firstnameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Firstname"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your firstname';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: lastnameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Lastname"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your lastname';
                        }
                        return null;
                      },
                    ),
                  ),
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
                      controller: companyController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Company"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your company';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: positionController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: "Position"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your position';
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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Confirm password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter again your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 16.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (passwordController.text ==
                                confirmPasswordController.text) {
                              try {
                                User user = User(
                                    firstnameController.text,
                                    lastnameController.text,
                                    emailController.text,
                                    companyController.text,
                                    positionController.text,
                                    passwordController.text);
                                await _sqliteService
                                    .createUser(user)
                                    .then((value) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Home()));
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'There was a problem adding a user, please try again')),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Passwords does not match')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please fill input')),
                            );
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ),
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
