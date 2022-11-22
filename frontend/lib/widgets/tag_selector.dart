import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/screens/card_process_screen.dart';
import 'package:frontend/widgets/card_item.dart';
import 'package:http/http.dart' as http;

class TagSelector extends StatefulWidget {
  const TagSelector({Key? key}) : super(key: key);

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  Future<List<String>> fetchTags() async {
    var uri = Uri.http('localhost:8080', 'api/tags');
    var response = await http.get(uri);
    List<dynamic> tags = json.decode(response.body);

    return tags.map((e) => e['tag'].toString()).toList();
  }

  List<String> tags = [];

  @override
  void initState() {
    fetchTags().then((value) => {
          setState(() {
            tags = value;
          })
        });
    super.initState();
  }

  selectAction(String tag) {
    Future.delayed(const Duration(milliseconds: 250), () {
      Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => CardProcessScreen(tag: tag)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scrollbar(
        thumbVisibility: false,
        trackVisibility: false,
        child: Wrap(
          children: [
            ...tags.map(
              (e) => CardItem(
                tag: e,
                selectAction: selectAction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
