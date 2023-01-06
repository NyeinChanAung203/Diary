import 'package:diary/providers/diary_provider.dart';

import 'package:diary/routes/routes.dart';

import 'package:diary/widgets/homeScreen/custom_appbar.dart';
import 'package:diary/widgets/homeScreen/diary_card.dart';

import 'package:diary/widgets/search_input_field.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController? controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /* AppBar */
            CustomAppBar(
              title: SearchInputField(
                hintText: 'Search diaries',
                enabled: true,
                controller: controller,
                focusNode: focusNode,
                onChanged: Provider.of<DiaryProvider>(context, listen: false)
                    .searchDiary,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<DiaryProvider>(
                builder: (context, value, child) {
                  final searchList = value.searchList;
                  return ListView.builder(
                      itemCount: searchList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(Routes.diaryDetail,
                                arguments: searchList[index]);
                          },
                          child: DiaryCard(
                              updated: searchList[index].updated,
                              title: searchList[index].title,
                              description: searchList[index].description,
                              image: searchList[index].imageUrl,
                              dateTime: searchList[index].dateTime,
                              tags: searchList[index].tags,
                              isStarred: searchList[index].isStarred,
                              mood: searchList[index].mood),
                        );
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
