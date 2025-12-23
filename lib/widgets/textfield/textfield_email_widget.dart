import 'package:flutter/material.dart';

class TextfieldPasswordWidget extends StatefulWidget {
  const TextfieldPasswordWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<TextfieldPasswordWidget> createState() =>
      _TextfieldPasswordWidgetState();
}

class _TextfieldPasswordWidgetState extends State<TextfieldPasswordWidget> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color.fromARGB(255, 41, 40, 40),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: widget.controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: "Insert Password....",
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: const Icon(Icons.remove_red_eye_rounded),
            ),
          ),
        ),
      ],
    );
  }
}
