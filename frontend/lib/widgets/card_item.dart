import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  final String tag;
  final Function selectAction;

  const CardItem({Key? key, required this.tag, required this.selectAction})
      : super(key: key);

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  double elevation = 10;


  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  SizedBox buildBody() {
    return SizedBox(
      width: 400,
      height: 200,
      child: _buildCard(),
    );
  }

  Card _buildCard() {
    return Card(
      elevation: elevation,
      margin: const EdgeInsets.all(25),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20),),),
      child: _buildCardContentWithHoverEffect(),
    );
  }

  InkWell _buildCardContentWithHoverEffect() {
    return InkWell(
      autofocus: false,
      highlightColor: null,
      focusColor: null,
      overlayColor: null,
      hoverColor: Colors.transparent,
      onTap: () {
        widget.selectAction(widget.tag);
      },
      onHover: (isHover) {
        if (isHover) {
          setState(() {
            elevation = 20;
          });
        } else {
          setState(() {
            elevation = 10;
          });
        }
      },
      child: _buildCardContent(),
    );
  }


  Widget _buildCardContent() {
    return Center(child: Text(widget.tag))
  }

}
