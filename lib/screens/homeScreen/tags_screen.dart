import 'package:diary/models/diary_model.dart';
import 'package:diary/providers/theme_provider.dart';
import 'package:diary/widgets/homeScreen/custom_appbar.dart';
import 'package:diary/widgets/search_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({
    Key? key,
    this.diaryModel,
    this.tags,
  }) : super(key: key);

  final DiaryModel? diaryModel;
  final List<String>? tags;
  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  final TextEditingController _tagAddController = TextEditingController();
  List<String>? _tags;

  @override
  void initState() {
    super.initState();
    if (widget.tags != null) {
      _tags = widget.tags;
    } else {
      _tags = [];
    }
  }

  @override
  void dispose() {
    _tagAddController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            CustomAppBar(
              onPop: () {
                Navigator.of(context).pop(_tags);
              },
              title: Text(
                'Tags',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            // Container(
            //     margin: const EdgeInsets.symmetric(
            //       horizontal: 20,
            //       vertical: 10,
            //     ),
            //     child: const SearchInputField(
            //         enabled: true, hintText: 'Search tags')),
            Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: SearchInputField(
                  controller: _tagAddController,
                  enabled: true,
                  hintText: 'Add',
                  prefixIcon: Icons.sell_outlined,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (_tagAddController.text.trim().isNotEmpty) {
                        setState(() {
                          _tags!.add(_tagAddController.text.trim());
                        });
                      }
                      _tagAddController.text = '';
                    },
                    child: Icon(
                      Icons.add,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                    ),
                  ),
                )),
            Column(
              children: _tags != null
                  ? _tags!
                      .map(
                        (e) => TagListTile(
                          tagName: e,
                          onTapDelete: () {
                            setState(() {
                              _tags!.remove(e);
                            });
                          },
                        ),
                      )
                      .toList()
                      .reversed
                      .toList()
                  : [],
            ),
          ]),
        ),
      ),
    );
  }
}

class TagListTile extends StatelessWidget {
  const TagListTile({
    Key? key,
    required this.tagName,
    this.onTapDelete,
  }) : super(key: key);

  final String tagName;

  final Function()? onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.watch<ThemeProvider>().primaryColor.withOpacity(0.5),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(tagName),
        IconButton(
          onPressed: onTapDelete,
          icon: const Icon(Icons.delete),
          splashRadius: 20,
        ),
      ]),
    );
  }
}
