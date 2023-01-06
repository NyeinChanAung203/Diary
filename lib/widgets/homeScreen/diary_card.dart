import 'dart:convert';
import 'dart:typed_data';

import 'package:diary/utils/constants.dart';

import 'package:diary/widgets/tag_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_quill/flutter_quill.dart' as quill;

class DiaryCard extends StatelessWidget {
  const DiaryCard({
    Key? key,
    required this.title,
    required this.description,
    this.image,
    required this.dateTime,
    this.tags,
    this.mood,
    required this.isStarred,
    required this.updated,
    this.isCheck,
    this.selectOnChanged,
  }) : super(key: key);

  final String title, description;
  final Uint8List? image;
  final DateTime dateTime, updated;
  final List<String>? tags;
  final String? mood;
  final bool isStarred;
  final bool? isCheck;
  final void Function(bool?)? selectOnChanged;

  Color moodColorCatcher(String? mood) {
    switch (mood) {
      case joyfulEmoji:
        return joyfulMoodColor;
      case happyEmoji:
        return happyMoodColor;
      case normalEmoji:
        return normalMoodColor;
      case sadEmoji:
        return sadMoodColor;
      case angryEmoji:
        return angryMoodColor;
      default:
        return const Color(0xff888888).withOpacity(0.5);
    }
  }

  String toPlainText(String desc) {
    var myJSON = jsonDecode(desc);
    return quill.Document.fromJson(myJSON).toPlainText();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 20,
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: moodColorCatcher(mood),
            ),
            child: Column(children: [
              /* Date and Time */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${DateFormat.yMMMd('en_US').format(dateTime)} $mood ${isStarred ? starEmoji : ''}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).textTheme.titleLarge!.color,
                        ),
                  ),
                  Text(
                    DateFormat.jm().format(updated),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).textTheme.titleLarge!.color,
                        ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //----
                  // desc,tag,title
                  Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /* Description */
                      SizedBox(
                        width: 200,
                        child: Text(
                          toPlainText(description),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .color,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /* Tags */
                      SizedBox(
                        width: 200,
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(
                            'Tags: ',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color,
                                    ),
                          ),
                          (tags != null)
                              ? SizedBox(
                                  width: 150,
                                  child: Wrap(
                                    spacing: 5,
                                    runSpacing: 5,
                                    children: tags!.length > 4
                                        ? tags!
                                            .map((e) => TagCard(
                                                  text: e,
                                                ))
                                            .toList()
                                            .getRange(0, 3)
                                            .toList()
                                        : tags!
                                            .map((e) => TagCard(
                                                  text: e,
                                                ))
                                            .toList(),
                                  ),
                                )
                              : const SizedBox()
                        ]),
                      )
                    ],
                  ),

                  //for pic
                  Column(
                    children: [
                      /* Cover Photo */
                      image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: isCheck == null ? 100 : 60,
                                height: isCheck == null ? 100 : 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.memory(
                                  image!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  )

                  //--
                ],
              )
            ]),
          ),
        ),
        isCheck == null
            ? const SizedBox()
            : Checkbox(
                value: isCheck,
                fillColor: MaterialStateProperty.all(primaryColor),
                onChanged: (v) {})
      ],
    );
  }
}
