import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/models/flash_card_tag.dart';
import 'package:frontend/screens/card_process_screen.dart';
import 'package:frontend/widgets/card_item.dart';
import 'package:http/http.dart' as http;

class TagSelector extends StatefulWidget {
  const TagSelector({Key? key}) : super(key: key);

  @override
  State<TagSelector> createState() => _TagSelectorState();
}

class _TagSelectorState extends State<TagSelector> {
  Future<List<FlashCardTag>> fetchTags() async {
    var uri = Uri.http('localhost:8080', 'api/tags');
    var response = await http.get(uri);

    List<dynamic> list = json.decode(response.body);

    return list.map((e) => FlashCardTag.fromJson(e)).toList();
  }

  List<FlashCardTag> tags = [];

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
    FlashCardTag flashCardTag =
        tags.singleWhere((element) => element.tag == tag);
    int incrementSize = 5;
    if (flashCardTag.count! > 100) incrementSize = 10;

    var count = num.tryParse('${flashCardTag.count}');

    if (flashCardTag.count! <= 5) {
      goToNextPage(tag, flashCardTag.count!);
      return;
    }

    List<Widget> widgets = [];
    _generateCountSelectionList(count, incrementSize, widgets, tag);
    _generateDialog(widgets);
  }

  Future<Object?> _generateDialog(List<Widget> widgets) {
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.35),
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
            alignment: Alignment.center,
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
              child: Align(
                alignment: Alignment.center,
                child: Wrap(
                  children: [
                    ...widgets,
                  ],
                ),
              ),
            ));
      },
      transitionDuration: const Duration(milliseconds: 300),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
    );
  }

  void _generateCountSelectionList(
      num? count, int incrementSize, List<Widget> widgets, String tag) {
    for (int i = 0; i <= count!; i += incrementSize) {
      if (i != 0) {
        widgets.add(
          _generateCountSelectionCard(tag, i),
        );
      }
    }
  }

  Card _generateCountSelectionCard(String tag, int i) {
    return Card(
      elevation: 25,
      child: InkWell(
        onTap: () {
          Navigator.of(context, rootNavigator: true).pop();
          goToNextPage(tag, i);
        },
        child: SizedBox(
          height: 100,
          width: 100,
          child: Center(
            child: Text(
                style: const TextStyle(
                  fontSize: 48,
                ),
                '$i'),
          ),
        ),
      ),
    );
  }

  goToNextPage(String tag, int count) {
    Future.delayed(const Duration(milliseconds: 250), () {
      Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                CardProcessScreen(tag: tag, cardCount: count)),
      ).then((_) => {
            fetchTags().then((value) => (setState(() {
                  tags = value;
                })))
          });
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
                flashCardTag: e,
                selectAction: selectAction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
