import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/flash_card_tag.dart';

class CardItem extends StatefulWidget {
  final FlashCardTag flashCardTag;
  final Function selectAction;

  const CardItem({Key? key, required this.flashCardTag, required this.selectAction})
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
        widget.selectAction(widget.flashCardTag.tag);
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
                widget.flashCardTag.tag!),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatisticsColumn(const FaIcon(FontAwesomeIcons.eye), widget.flashCardTag.cardsSeenCount.toString()),
              _buildStatisticsColumn(const FaIcon(FontAwesomeIcons.graduationCap), widget.flashCardTag.uniqueCardsSeenCount.toString()),
              _buildStatisticsColumn(const FaIcon(FontAwesomeIcons.clone), widget.flashCardTag.count.toString()),
              _buildStatisticsColumn(
                  const FaIcon(
                    FontAwesomeIcons.check,
                    color: Colors.green,
                  ),
                  widget.flashCardTag.correctCount.toString()),
              _buildStatisticsColumn(
                  const FaIcon(
                    FontAwesomeIcons.xmark,
                    color: Colors.red,
                  ),
                  widget.flashCardTag.incorrectCount.toString()),
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
