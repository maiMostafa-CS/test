import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
   VoidCallback onPressed;
   String title;
   Color? color;
   Color? textColor;
   double? borderRadius;
   double? width;
   IconData? icon;
   CustomButton({super.key,
     required this.onPressed,
     required  this.title,
     this.color,
     this.textColor,
     this.borderRadius,
      this.width,
      this.icon


   });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: widget.color ?? Colors.blue,
      textColor: widget.textColor ?? Colors.white,

      padding: EdgeInsets.symmetric(horizontal: widget.width??100, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
      ),
      onPressed: widget.onPressed,
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.title),
SizedBox(width: 10,),
          Icon(
              widget.icon, size: 20),
        ],
      )
    );
  }
}
