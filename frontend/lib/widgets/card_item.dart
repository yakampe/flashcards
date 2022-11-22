import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
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
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                widget.tag),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatisticsColumn(const FaIcon(FontAwesomeIcons.eye), "0"),
              _buildStatisticsColumn(const FaIcon(FontAwesomeIcons.clone), "0"),
              _buildStatisticsColumn(
                  const FaIcon(
                    FontAwesomeIcons.check,
                    color: Colors.green,
                  ),
                  "0"),
              _buildStatisticsColumn(
                  const FaIcon(
                    FontAwesomeIcons.xmark,
                    color: Colors.red,
                  ),
                  "0"),
            ],
          ),
        )
      ],
    );
  }

  Column _buildStatisticsColumn(FaIcon icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [icon, Text(text)],
    );
  }
}
