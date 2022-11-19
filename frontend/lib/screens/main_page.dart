import 'package:flutter/material.dart';

import '../widgets/app_bar_actions.dart';
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarActions(),
      ),
      body: Center(
        child: Column(
          children: const [Text('body')],
        ),
      ),
    );
  }
}

