import 'package:flutter/material.dart';
import 'package:frontend/widgets/card_item.dart';

class TagSelector extends StatefulWidget {
  const TagSelector({Key? key}) : super(key: key);

  @override
  _TagSelectorState createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  double elevation = 2;
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: List.generate(
        20,
        (index) {
          return CardItem(
            text: '$index',
          );
        },
      ),
    );
  }
}
