import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String button_name;
  final void Function()? onTap;
  const MyButton({super.key,
  required this.button_name,
  required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Text(button_name,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),),
        ),
      ),
    );
  }
}
