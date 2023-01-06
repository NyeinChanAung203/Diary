import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:diary/models/diary_model.dart';
import 'package:diary/providers/diary_provider.dart';
import 'package:diary/providers/theme_provider.dart';

import 'package:diary/screens/homeScreen/tags_screen.dart';

import 'package:diary/utils/constants.dart';

import 'package:diary/widgets/homeScreen/custom_appbar.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:provider/provider.dart';

import 'package:select_form_field/select_form_field.dart';

class DiaryEditAddScreen extends StatefulWidget {
  const DiaryEditAddScreen({
    Key? key,
    this.diaryModel,
    required this.isEdit,
  }) : super(key: key);

  final DiaryModel? diaryModel;
  final bool isEdit;

  @override
  State<DiaryEditAddScreen> createState() => _DiaryEditAddScreenState();
}

class _DiaryEditAddScreenState extends State<DiaryEditAddScreen> {
  @override
  void initState() {
    super.initState();

    if (widget.diaryModel != null) {
      _titleController.text = widget.diaryModel!.title;
      tags = widget.diaryModel!.tags;
      isStarred = widget.diaryModel!.isStarred;

      showDateText = ValueNotifier(
          DateFormat.yMMMd('en_US').format(widget.diaryModel!.dateTime));
      selectedDate = ValueNotifier(widget.diaryModel!.dateTime);

      _moodController.text = widget.diaryModel?.mood ?? '';

      _uint8list.value = widget.diaryModel?.imageUrl;
      //* show detail */
      var myJSON = jsonDecode(widget.diaryModel!.description);
      _quillController = quill.QuillController(
          document: quill.Document.fromJson(myJSON),
          selection: const TextSelection.collapsed(offset: 0));
    }
  }

  bool isStarred = false;

  ValueNotifier<String> showDateText =
      ValueNotifier(DateFormat.yMMMd('en_US').format(DateTime.now()));

  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());

  void _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(1920),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: context.watch<ThemeProvider>().primaryColor,
              ),
            ),
            child: child!,
          );
        });

    if (selected != null && selected != selectedDate.value) {
      selectedDate.value = selected;
      showDateText.value = DateFormat.yMMMd('en_US').format(selected);
    }
  }

  quill.QuillController _quillController = quill.QuillController.basic();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _moodController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  List<Map<String, dynamic>> items = [
    {
      'value': joyfulEmoji,
      'label': '$joyfulEmoji  Joyful',
    },
    {
      'value': happyEmoji,
      'label': '$happyEmoji  Happy',
    },
    {
      'value': normalEmoji,
      'label': '$normalEmoji  Normal',
    },
    {
      'value': sadEmoji,
      'label': '$sadEmoji  Sad',
    },
    {
      'value': angryEmoji,
      'label': '$angryEmoji  Angry',
    },
    {
      'value': null,
      'label': 'No Feeling',
    },
  ];

  ValueNotifier<File?> imageFile = ValueNotifier(null);
  final ImagePicker _picker = ImagePicker();

  // Uint8List? _uint8list;
  final ValueNotifier<Uint8List?> _uint8list = ValueNotifier(null);

  _getFromGallery() async {
    PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      _uint8list.value = imageFile.value?.readAsBytesSync();
    }
  }

  List<String>? tags;

  @override
  void dispose() {
    _titleController.dispose();
    _quillController.dispose();
    _moodController.dispose();
    imageFile.dispose();
    _uint8list.dispose();
    showDateText.dispose();
    selectedDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: Form(
                key: _formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                  controller: _titleController,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Title'),
                ),
              ),
              action: Row(
                children: [
                  ValueListenableBuilder(
                      valueListenable: showDateText,
                      builder: (context, value, child) {
                        return TextButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Row(
                            children: [
                              Text(
                                showDateText.value.toString(),
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color,
                              ),
                            ],
                          ),
                        );
                      }),
                  IconButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var json = jsonEncode(
                            _quillController.document.toDelta().toJson());

                        if (widget.isEdit) {
                          // print('isEdited');
                          // print('Title ${widget.diaryModel?.title}');
                          // print(
                          //     'Description ${widget.diaryModel?.description}');
                          // print('Tags ${widget.diaryModel?.tags}');
                          // print('ImageUrL ${widget.diaryModel?.imageUrl}');
                          // print('Mood ${widget.diaryModel?.mood}');
                          // print('Starred ${widget.diaryModel?.isStarred}');
                          // print('DateTime ${widget.diaryModel?.dateTime}');
                          Provider.of<DiaryProvider>(context, listen: false)
                              .updateDiary(
                                  widget.diaryModel!,
                                  _titleController.text,
                                  json,
                                  _uint8list.value,
                                  tags,
                                  _moodController.value.text,
                                  isStarred,
                                  DateFormat.yMMMd('en_US')
                                      .parse(showDateText.value),
                                  DateTime.now());

                          Navigator.of(context).pop();
                        } else {
                          var dm = DiaryModel(
                            title: _titleController.text,
                            description: json,
                            isStarred: isStarred,
                            imageUrl: _uint8list.value,
                            tags: tags,
                            mood: _moodController.value.text,
                            dateTime: DateFormat.yMMMd('en_US')
                                .parse(showDateText.value),
                            updated: DateTime.now(),
                          );

                          // print('Title ${dm.title}');
                          // print('Description ${dm.description}');
                          // print(tags);
                          // print('Tags ${dm.tags}');
                          // print('ImageUrL ${dm.imageUrl}');
                          // print('Mood ${dm.mood}');
                          // print('Starred ${dm.isStarred}');
                          // print('DateTime ${dm.dateTime}');
                          // dummyDiary.add(dm);
                          Provider.of<DiaryProvider>(context, listen: false)
                              .createDiary(dm);
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    icon: const Icon(Icons.check),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () async {
                        tags =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TagsScreen(
                                      diaryModel: widget.diaryModel,
                                      tags: tags,
                                    )));
                      },
                      icon: const Icon(Icons.sell_sharp)),
                  SizedBox(
                    width: 202,
                    child: SelectFormField(
                      textAlign: TextAlign.center,
                      dialogTitle: 'How do you feel?',
                      dialogCancelBtn: 'Cancle',
                      controller: _moodController,
                      type: SelectFormFieldType.dialog,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'How do you feel?',
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        hintStyle:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
                      items: items,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        _getFromGallery();
                      },
                      icon: _uint8list.value != null
                          ? ValueListenableBuilder(
                              valueListenable: _uint8list,
                              builder: (context, Uint8List? value, child) {
                                return Image.memory(_uint8list.value!);
                              },
                            )
                          : ValueListenableBuilder(
                              valueListenable: imageFile,
                              builder: (context, File? value, child) {
                                if (value == null) {
                                  return const Icon(Icons.photo);
                                } else {
                                  return Image.file(
                                    value,
                                    fit: BoxFit.cover,
                                  );
                                }
                              },
                            ))
                ],
              ),
            ),
            Divider(
              color: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .color
                  ?.withOpacity(0.2),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
                margin: const EdgeInsets.only(bottom: 10),
                child: quill.QuillEditor.basic(
                    controller: _quillController, readOnly: false),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: quill.QuillToolbar.basic(
        controller: _quillController,
        iconTheme: quill.QuillIconTheme(
          iconSelectedFillColor: context.watch<ThemeProvider>().primaryColor,
        ),
        multiRowsDisplay: false,
      ),
    );
  }
}
