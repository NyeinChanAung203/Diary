import 'dart:convert';

import 'package:diary/models/deleted_diary_model.dart';
import 'package:diary/models/diary_model.dart';
import 'package:diary/providers/deleted_diary_provider.dart';
import 'package:diary/providers/diary_provider.dart';
import 'package:diary/providers/theme_provider.dart';

import 'package:diary/screens/homeScreen/diary_add_edit_screen.dart';

import 'package:diary/utils/constants.dart';

import 'package:diary/widgets/homeScreen/custom_appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';

import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

class DiaryDetailScreen extends StatefulWidget {
  const DiaryDetailScreen({
    Key? key,
    required this.diaryModel,
  }) : super(key: key);

  final DiaryModel diaryModel;

  @override
  State<DiaryDetailScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryDetailScreen> {
  String? filePath;
  Future<void> createPdfFile() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) => [
                pw.Header(
                  child: pw.Text(widget.diaryModel.title,
                      style: const pw.TextStyle(fontSize: 26)),
                ),
                pw.Text(
                  DateFormat.yMMMd('en_US').format(widget.diaryModel.dateTime),
                  style: const pw.TextStyle(fontSize: 22),
                ),
                pw.SizedBox(height: 30),
                pw.Paragraph(
                    text: _quillController.document.toPlainText(),
                    style: const pw.TextStyle(fontSize: 18)),
              ]),
    );
    Directory documentDirectory =
        (await getExternalStorageDirectories(type: StorageDirectory.documents))!
            .first;
    String documentPath = documentDirectory.path;

    final file = File('$documentPath/${widget.diaryModel.title}.pdf');
    filePath = file.path;

    await file.writeAsBytes(await pdf.save());
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.diaryModel.title;
    showDateText = DateFormat.yMMMd('en_US').format(widget.diaryModel.dateTime);

    //* show detail */
    var myJSON = jsonDecode(widget.diaryModel.description);
    _quillController = quill.QuillController(
        document: quill.Document.fromJson(myJSON),
        selection: const TextSelection.collapsed(offset: 0));
  }

  late String showDateText;

  late quill.QuillController _quillController;

  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _quillController.dispose();

    super.dispose();
  }

  Color? getRelatedBgColor(String? mood) {
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
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryProvider>(
      builder: (context, provider, child) {
        DiaryModel detailDiary = provider.detailDiary(widget.diaryModel);
        _titleController.text = detailDiary.title;
        // description
        var myJSON = jsonDecode(detailDiary.description);
        _quillController = quill.QuillController(
            document: quill.Document.fromJson(myJSON),
            selection: const TextSelection.collapsed(offset: 0));
        // date
        showDateText = DateFormat.yMMMd('en_US').format(detailDiary.dateTime);
        final isStarred = provider.getStarred(widget.diaryModel);
        return Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: getRelatedBgColor(detailDiary.mood),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  CustomAppBar(
                      bgColor: getRelatedBgColor(widget.diaryModel.mood),
                      title: Form(
                        child: TextFormField(
                          enabled: false,
                          controller: _titleController,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Title'),
                        ),
                      ),
                      action: Row(
                        children: [
                          Text(detailDiary.mood.toString()),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            showDateText,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .color,
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          widget.diaryModel.imageUrl != null
                              ? Image.memory(
                                  widget.diaryModel.imageUrl!,
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                  fit: BoxFit.contain,
                                )
                              : const SizedBox(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: quill.QuillEditor.basic(
                                controller: _quillController, readOnly: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              diaryActionBtn(
                  label: 'Star',
                  icon: isStarred ? Icons.star : Icons.star_border,
                  iconColor: isStarred ? Colors.yellow : Colors.white,
                  onTap: () {
                    provider.setStarred(widget.diaryModel, isStarred);
                  }),
              diaryActionBtn(
                  label: 'Edit',
                  icon: Icons.edit,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DiaryEditAddScreen(
                              isEdit: true,
                              diaryModel: widget.diaryModel,
                            )));
                  }),
              diaryActionBtn(
                  label: 'Backup',
                  icon: Icons.download,
                  onTap: () async {
                    await createPdfFile().then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.black87,
                          duration: const Duration(seconds: 5),
                          content: Text(
                            "Successfully Saved in [$filePath]",
                            style: const TextStyle(color: Color(0xFFefac4a)),
                          )));
                    });
                  }),
              diaryActionBtn(
                  label: 'Delete',
                  icon: Icons.delete,
                  color: Colors.red,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Row(
                                children: [
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Are you sure ?',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .color,
                                    ),
                                  ),
                                ],
                              ),
                              buttonPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              content: Text(
                                'Do you really want to delete this diary?',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .color),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: context
                                              .read<ThemeProvider>()
                                              .primaryColor),
                                    )),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom().copyWith(
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    onPressed: () {
                                      Provider.of<DiaryProvider>(context,
                                              listen: false)
                                          .deleteDiary(widget.diaryModel);

                                      // add to trash
                                      var dm = DeletedDiaryModel(
                                        title: widget.diaryModel.title,
                                        description:
                                            widget.diaryModel.description,
                                        isStarred: widget.diaryModel.isStarred,
                                        imageUrl: widget.diaryModel.imageUrl,
                                        tags: widget.diaryModel.tags,
                                        mood: widget.diaryModel.mood,
                                        dateTime: widget.diaryModel.dateTime,
                                        updated: widget.diaryModel.updated,
                                      );
                                      Provider.of<DeletedDiaryProvider>(context,
                                              listen: false)
                                          .createDeletedDiary(dm);
                                      // pop
                                      Navigator.of(context)
                                        ..pop()
                                        ..pop();
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ],
                            ));
                  }),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  InkWell diaryActionBtn(
      {required IconData icon,
      required String label,
      Function()? onTap,
      Color? color,
      Color? iconColor}) {
    return InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: Ink(
            width: 50,
            height: 50,
            // padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color ?? searchRelatedColor.withOpacity(1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(label,
                    style: const TextStyle(color: Colors.white, fontSize: 9)),
              ],
            )));
  }
}
