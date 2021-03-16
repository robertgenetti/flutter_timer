import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  const ProductivityButton({
    Key key,
    @required this.color,
    @required this.text,
    @required this.onPressed,
    this.size = 150.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.onPressed,
      color: this.color,
      minWidth: this.size,
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
