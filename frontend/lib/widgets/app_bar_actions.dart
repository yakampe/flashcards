import 'package:flutter/cupertino.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text('Flash Cards'),
      ],
    );
  }
}
