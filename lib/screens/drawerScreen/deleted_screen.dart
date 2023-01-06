import 'package:diary/models/diary_model.dart';

import 'package:diary/providers/deleted_diary_provider.dart';
import 'package:diary/providers/diary_provider.dart';

import 'package:diary/widgets/homeScreen/custom_appbar.dart';
import 'package:diary/widgets/homeScreen/diary_card.dart';
import 'package:diary/widgets/search_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeletedScreen extends StatefulWidget {
  const DeletedScreen({Key? key}) : super(key: key);

  @override
  State<DeletedScreen> createState() => _DeletedScreenState();
}

class _DeletedScreenState extends State<DeletedScreen> {
  final TextEditingController _deletedController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _deletedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DeletedDiaryProvider>(
      builder: (context, DeletedDiaryProvider provider, child) {
        final deletedDiaries = _deletedController.text.isEmpty
            ? provider.getAllDeletedDiaries()
            : provider.deletedDiariesSearchList;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                CustomAppBar(
                  fullScreenDialog: provider.selectMode,
                  onPop: () {
                    provider.selectMode
                        ? provider.disableSelectionMode()
                        : Navigator.of(context).pop();
                  },
                  title: Text(
                    provider.selectMode
                        ? '${provider.selectedDiaries.length} ${provider.selectedDiaries.length > 1 ? 'diaries' : 'diary'} selected'
                        : 'Deleted diaries',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: SearchInputField(
                        controller: _deletedController,
                        enabled: true,
                        hintText: 'Search deleted diaries',
                        onChanged: (value) {
                          Provider.of<DeletedDiaryProvider>(context,
                                  listen: false)
                              .searchdeletedDiary(value);
                        })),
                Column(
                    children: deletedDiaries
                        .map(
                          (diaryModel) => GestureDetector(
                            // onLongPress: () {
                            //   provider.onLongPress(diaryModel);
                            // },
                            onTap: () {
                              provider.turnOnSelectionMode();
                              provider.onTap(diaryModel);
                            },
                            child: DiaryCard(
                              image: diaryModel.imageUrl,
                              mood: diaryModel.mood,
                              tags: diaryModel.tags,
                              title: diaryModel.title,
                              description: diaryModel.description,
                              dateTime: diaryModel.dateTime,
                              isStarred: diaryModel.isStarred,
                              updated: diaryModel.updated,
                              isCheck: provider.selectMode == false
                                  ? null
                                  : provider.selectedDiaries
                                      .contains(diaryModel),
                            ),
                          ),
                        )
                        .toList()
                        .reversed
                        .toList()),
              ]),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: provider.selectMode
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ActionButton(
                        label: 'Restore',
                        bgColor: Colors.green,
                        icon: Icons.restore,
                        onTap: () {
                          final diaryProvider = Provider.of<DiaryProvider>(
                              context,
                              listen: false);
                          // create selected diaries from deleted-list
                          for (var element in provider.selectedDiaries) {
                            var dm = DiaryModel(
                              title: element.title,
                              description: element.description,
                              isStarred: element.isStarred,
                              imageUrl: element.imageUrl,
                              tags: element.tags,
                              mood: element.mood,
                              dateTime: element.dateTime,
                              updated: element.updated,
                            );
                            diaryProvider.createDiary(dm);
                          }
                          // delete selected diaries from deleted-list
                          provider
                              .deleteSelectedDiaries(provider.selectedDiaries);
                        },
                      ),
                      // SizedBox(
                      //   width: 30,
                      // ),
                      ActionButton(
                        label: 'Delete',
                        bgColor: Colors.red,
                        icon: Icons.delete_forever,
                        onTap: () {
                          provider
                              .deleteSelectedDiaries(provider.selectedDiaries);
                        },
                      ),

                      ActionButton(
                        label: 'Select All',
                        bgColor: Colors.grey.shade700,
                        icon: Icons.select_all,
                        onTap: () {
                          provider.selectAll();
                        },
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        );
      },
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onTap,
    required this.label,
    required this.icon,
    required this.bgColor,
  }) : super(key: key);

  final void Function()? onTap;
  final String label;
  final IconData icon;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Ink(
        height: 50,
        width: 50,
        // padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 7,
            ),
          ),
        ]),
      ),
    );
  }
}

class TagListTile extends StatelessWidget {
  const TagListTile({
    Key? key,
    this.onTapSelect,
    this.onTapDelete,
  }) : super(key: key);

  final Function()? onTapSelect;
  final Function()? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapSelect,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          // Text(tagModel.name),
          IconButton(
            onPressed: onTapDelete,
            icon: const Icon(Icons.delete),
            splashRadius: 20,
          ),
        ]),
      ),
    );
  }
}
