import 'package:flutter/material.dart';
import 'package:frontend/widgets/tag_selector.dart';

import '../widgets/app_bar_actions.dart';
class TagSelectorScreen extends StatelessWidget {
  const TagSelectorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarActions(),
      ),
      body: const Center(
        child: TagSelector(),
      ),
    );
  }
}

