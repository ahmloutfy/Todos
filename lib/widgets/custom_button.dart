import 'package:flutter/material.dart';



class CustomButton extends StatefulWidget {

  final void Function()? press;
  final Color color;
final Icon customIcon;
final EdgeInsets customMargin;

  const CustomButton({Key? key, required this.press, required this.color, required this.customIcon, required this.customMargin}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.customMargin,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5),
      ),
      height: 35,
      width: 45,
      child: IconButton(
        padding: const EdgeInsets.only(bottom: 2),
        onPressed: widget.press
        , icon: widget.customIcon,
        color: Colors.white,

      ),
    );
  }
}

