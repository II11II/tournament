import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Widget title;

  final double height;
  final double width;
  final Function onPressed;
  final List<Color> colors;
  final BorderRadiusGeometry borderRadius;

  const CustomButton(
      {Key key,
      this.text,
      this.title,
      this.height,
      this.width,
      this.onPressed,
      this.colors, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(borderRadius:borderRadius?? BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: colors??[Color(0xff176FD0), Color(0xff1DA8F6)],
            begin:  Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
      child: FlatButton(
        onPressed: onPressed,
        child: Center(
          child: title ??
              Text(
                text,
                style: TextStyle(fontSize: 17,color: Colors.white),
              ),
        ),
      ),
    );
  }
}
