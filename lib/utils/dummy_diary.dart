import 'dart:convert';

import 'package:diary/models/diary_model.dart';

import 'package:flutter_quill/flutter_quill.dart' as quill;

var desc = [
  {"insert": "Fggh"},
  {
    "insert": "hhzfhgg",
    "attributes": {"bold": true}
  },
  {
    "insert": "gxgdkyyd",
    "attributes": {"bold": true, "italic": true}
  },
  {
    "insert": "gjdxjggjx",
    "attributes": {"bold": true, "italic": true, "color": "#26c6da"}
  },
  {"insert": "\n\ntsjstyjdykjf"},
  {
    "insert": "hmdxhmdchj",
    "attributes": {"color": "#f44336"}
  },
  {"insert": "\nGxnhxgnxgn"},
  {
    "insert": "chch",
    "attributes": {"color": "#ffea00"}
  },
  {"insert": "\nXhxhxh"},
  {
    "insert": "xhfhcjcjcjjc",
    "attributes": {"color": "#8bc34a"}
  },
  {"insert": "\n\n"}
];

String descriptionDummy =
    jsonEncode(quill.Document.fromJson(desc).toDelta().toJson());

// List<DiaryModel> dummyDiary = [
//   DiaryModel(
//     title: 'InterView',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: ['interview', 'work'],
//     mood: Moods.angry,
//     dateTime: DateTime.now(),
//     isStarred: true,
//   ),
//   DiaryModel(
//     title: 'InterView 2',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: ['interview', 'work'],
//     mood: Moods.happy,
//     dateTime: DateTime.now(),
//     isStarred: false,
//   ),
//   DiaryModel(
//     title: 'InterView 3',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: ['interview', 'work'],
//     mood: Moods.joyful,
//     dateTime: DateTime.now(),
//     isStarred: true,
//   ),
//   DiaryModel(
//     title: 'InterView 5',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: ['interview', 'work'],
//     mood: Moods.normal,
//     dateTime: DateTime.now(),
//     isStarred: false,
//   ),
//   DiaryModel(
//     title: 'InterView 6',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: ['interview', 'work'],
//     mood: Moods.sad,
//     dateTime: DateTime.now(),
//     isStarred: false,
//   ),
//   DiaryModel(
//     title: 'InterView 7',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: ['interview', 'work'],
//     mood: Moods.happy,
//     dateTime: DateTime.now(),
//     isStarred: true,
//   ),
//   DiaryModel(
//     title: 'Dummy Diary Data',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: null,
//     mood: null,
//     dateTime: DateTime.now(),
//     isStarred: true,
//   ),
//   //
//   DiaryModel(
//     title: 'InterView',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: ['interview', 'work'],
//     mood: Moods.angry,
//     dateTime: DateTime.now(),
//     isStarred: true,
//   ),
//   DiaryModel(
//     title: 'InterView 2',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: ['interview', 'work'],
//     mood: Moods.happy,
//     dateTime: DateTime.now(),
//     isStarred: false,
//   ),
//   DiaryModel(
//     title: 'InterView 3',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: ['interview', 'work'],
//     mood: Moods.joyful,
//     dateTime: DateTime.now(),
//     isStarred: true,
//   ),
//   DiaryModel(
//     title: 'InterView 5',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: ['interview', 'work'],
//     mood: Moods.normal,
//     dateTime: DateTime.now(),
//     isStarred: false,
//   ),
//   DiaryModel(
//     title: 'InterView 6',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: ['interview', 'work'],
//     mood: Moods.sad,
//     dateTime: DateTime.now(),
//     isStarred: false,
//   ),
//   DiaryModel(
//     title: 'InterView 7',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: ['interview', 'work'],
//     mood: Moods.happy,
//     dateTime: DateTime.now(),
//     isStarred: true,
//   ),
//   DiaryModel(
//     title: 'Dummy Diary Data',
//     description: descriptionDummy,
//     imageUrl: avatarOne,
//     tags: null,
//     mood: null,
//     dateTime: DateTime.now(),
//     isStarred: true,
//   ),
// ];

List<DiaryModel> dummyDiary = [];
