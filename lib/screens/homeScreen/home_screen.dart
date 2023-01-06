import 'package:diary/providers/diary_provider.dart';
import 'package:diary/providers/theme_provider.dart';

import 'package:diary/routes/routes.dart';
import 'package:diary/screens/homeScreen/diary_add_edit_screen.dart';

import 'package:diary/utils/constants.dart';

import 'package:diary/widgets/homeScreen/custom_drawer.dart';
import 'package:diary/widgets/homeScreen/diary_card.dart';
import 'package:diary/widgets/homeScreen/welcome_header.dart';
import 'package:diary/widgets/search_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            content: const Text("Are you sure you want to exit?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  "Exit",
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final canPop = await showWarning(context);
        return canPop ?? false;
      },
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          backgroundColor: context
              .watch<ThemeProvider>()
              .primaryColor, //Theme.of(context).colorScheme.secondary,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(right: 17),
            child: SearchInputField(
              enabled: false,
              hintText: 'Search',
              onTap: () {
                Navigator.of(context).pushNamed(Routes.search);
              },
            ),
          ),
        ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeHeader(),
            Expanded(child: Consumer<DiaryProvider>(
              builder: (context, provider, child) {
                bool isEmpty = provider.isEmptyDiaries();
                return isEmpty
                    ? Center(
                        child: Text(
                          'Empty Diary',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                      )
                    : ListView(
                        children: [
                          /* Today */
                          if (provider.todayList.isNotEmpty) ...[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(Routes.today);
                                    },
                                    child: Text(
                                      'Today',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: context
                                                .watch<ThemeProvider>()
                                                .primaryColor,
                                          ),
                                    )),
                              ),
                            ),
                            Column(
                                children: provider.todayList
                                    .map((diary) => GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                Routes.diaryDetail,
                                                arguments: diary);
                                          },
                                          child: DiaryCard(
                                            title: diary.title,
                                            description: diary.description,
                                            image: diary.imageUrl,
                                            dateTime: diary.dateTime,
                                            tags: diary.tags,
                                            mood: diary.mood,
                                            isStarred: diary.isStarred,
                                            updated: diary.updated,
                                          ),
                                        ))
                                    .toList()
                                    .reversed
                                    .toList()),
                          ],

                          /* Yesterday */
                          if (provider.yesterdayList.isNotEmpty) ...[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(Routes.yesterday);
                                    },
                                    child: Text(
                                      'Yesterday',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: context
                                                .watch<ThemeProvider>()
                                                .primaryColor,
                                          ),
                                    )),
                              ),
                            ),
                            Column(
                                children: provider.yesterdayList
                                    .map((diary) => GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                Routes.diaryDetail,
                                                arguments: diary);
                                          },
                                          child: DiaryCard(
                                            title: diary.title,
                                            description: diary.description,
                                            image: diary.imageUrl,
                                            dateTime: diary.dateTime,
                                            tags: diary.tags,
                                            mood: diary.mood,
                                            isStarred: diary.isStarred,
                                            updated: diary.updated,
                                          ),
                                        ))
                                    .toList()),
                          ],

                          /* Recently */
                          if (provider.recentlyList.isNotEmpty) ...[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(Routes.recent);
                                    },
                                    child: Text(
                                      'Recently',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: context
                                                .watch<ThemeProvider>()
                                                .primaryColor,
                                          ),
                                    )),
                              ),
                            ),
                            Column(
                                children: provider.recentlyList
                                    .map((diary) => GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                Routes.diaryDetail,
                                                arguments: diary);
                                          },
                                          child: DiaryCard(
                                            title: diary.title,
                                            description: diary.description,
                                            image: diary.imageUrl,
                                            dateTime: diary.dateTime,
                                            tags: diary.tags,
                                            mood: diary.mood,
                                            isStarred: diary.isStarred,
                                            updated: diary.updated,
                                          ),
                                        ))
                                    .toList()),
                          ],
                        ],
                      );
              },
            )),
          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: context.watch<ThemeProvider>().primaryColor,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const DiaryEditAddScreen(isEdit: false)));
          },
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
    );
  }
}
