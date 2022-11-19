import 'package:flutter/cupertino.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text('FlashCardsApp'),
        SizedBox(
          width: 30,
        ),
        Text('Cards'),
        SizedBox(
          width: 30,
        ),
        Text('Tags'),
        SizedBox(
          width: 30,
        ),
        Text('Stats'),
      ],
    );
  }
}
