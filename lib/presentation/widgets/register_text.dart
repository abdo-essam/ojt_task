import 'package:flutter/material.dart';

class RegisterText extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterText({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don’t have an account?",
          style: TextStyle(color: Colors.black54),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            "Register",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
