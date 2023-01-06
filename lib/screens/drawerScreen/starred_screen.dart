import 'package:diary/providers/diary_provider.dart';
import 'package:diary/routes/routes.dart';

import 'package:diary/widgets/homeScreen/custom_appbar.dart';
import 'package:diary/widgets/homeScreen/diary_card.dart';
import 'package:diary/widgets/search_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StarredScreen extends StatefulWidget {
  const StarredScreen({Key? key}) : super(key: key);

  @override
  State<StarredScreen> createState() => _StarredScreenState();
}

class _StarredScreenState extends State<StarredScreen> {
  final TextEditingController _starredController = TextEditingController();

  @override
  void dispose() {
    _starredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            CustomAppBar(
              title: Text(
                'Starred diaries',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: SearchInputField(
                    controller: _starredController,
                    enabled: true,
                    hintText: 'Search starred diaries',
                    onChanged: (value) {
                      Provider.of<DiaryProvider>(context, listen: false)
                          .searchStarredDiary(value);
                    })),
            Consumer<DiaryProvider>(
              builder: (context, provider, child) {
                final starredDiaries = _starredController.text.isEmpty
                    ? provider.getAllStarredDiaries()
                    : provider.starredDiariesList;
                return Column(
                  children: starredDiaries
                      .map((diaryModel) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  Routes.diaryDetail,
                                  arguments: diaryModel);
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
                            ),
                          ))
                      .toList()
                      .reversed
                      .toList(),
                );
              },
            )
          ]),
        ),
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
