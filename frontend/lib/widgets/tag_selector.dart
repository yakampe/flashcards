import 'package:flutter/material.dart';
import 'package:frontend/widgets/card_item.dart';

class TagSelector extends StatelessWidget {
  const TagSelector({Key? key}) : super(key: key);


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
