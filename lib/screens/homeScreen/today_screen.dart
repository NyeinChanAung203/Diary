import 'package:diary/providers/diary_provider.dart';
import 'package:diary/routes/routes.dart';
import 'package:diary/widgets/homeScreen/custom_appbar.dart';
import 'package:diary/widgets/homeScreen/diary_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          CustomAppBar(
            title: Text('Today', style: Theme.of(context).textTheme.titleLarge),
            action: Text(
              DateFormat.yMMMd('en_US').format(DateTime.now()),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Consumer<DiaryProvider>(builder: (context, provider, child) {
            return Expanded(
              child: ListView(
                  padding: const EdgeInsets.only(top: 20),
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
            );
          })
        ],
      )),
    );
  }
}
