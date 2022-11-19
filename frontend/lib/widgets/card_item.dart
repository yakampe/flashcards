import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  final String text;

  const CardItem({Key? key, required this.text}) : super(key: key);

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  double elevation = 5;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      margin: const EdgeInsets.all(25),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: InkWell(
        autofocus: false,
        highlightColor: null,
        focusColor: null,
        overlayColor: null,
        hoverColor: Colors.transparent,
        onTap: () {},
        onHover: (isHover) {
          if (isHover) {
            setState(() {
              elevation = 10;
            });
          } else {
            setState(() {
              elevation = 2;
            });
          }
        },
        child: Center(child: Text(widget.text)),
      ),
    );
  }
}
