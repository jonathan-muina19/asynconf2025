import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Function()? onTap;
  final String textTitle;
  final Icon? icon;

  const MyButton({
    super.key,
    required this.onTap,
    required this.textTitle,
    required this.icon
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF1877F2),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) Icon(icon!.icon, color: Colors.white),
              SizedBox(width: 10),
              Text(textTitle, style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
