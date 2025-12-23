import 'package:flutter/material.dart';
import 'package:stuntfree_mobile/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final Color primaryColor = const Color(0xFFFF8383);

  @override
  Widget build(BuildContext context) {
    var loadAuth = Provider.of<AppAuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              SizedBox(
                height: 250,
                child: Image.asset(
                  "assets/images/stuntfree.png",
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  loadAuth.islogin ? "Login" : "Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(
                      context,
                    ).textTheme.headlineMedium?.fontSize,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Form(
                  key: loadAuth.form,
                  child: Column(
                    children: [
                      if (!loadAuth.islogin)
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(),
                          ),
                        ),

                      const SizedBox(height: 15),

                      TextField(
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextField(
                        controller: password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () {
                            loadAuth.submit(
                              name: name.text.trim(),
                              email: email.text.trim(),
                              password: password.text.trim(),
                            );
                          },
                          child: Text(
                            loadAuth.islogin ? "Login" : "Register",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextButton(
                        onPressed: () {
                          setState(() {
                            loadAuth.islogin = !loadAuth.islogin;
                          });
                        },
                        child: Text(
                          loadAuth.islogin
                              ? "Create account"
                              : "I already have an account",
                          style: TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
