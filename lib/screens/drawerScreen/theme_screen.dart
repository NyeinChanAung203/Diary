import 'package:diary/providers/theme_provider.dart';
import 'package:diary/utils/constants.dart';
import 'package:diary/widgets/homeScreen/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          CustomAppBar(
              title:
                  Text('Theme', style: Theme.of(context).textTheme.titleLarge)),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            leading: Icon(Icons.nightlight,
                color: Theme.of(context).iconTheme.color),
            title: Text(
              'Dark mode',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
            ),
            trailing:
                Consumer<ThemeProvider>(builder: (context, provider, child) {
              return Switch(
                activeColor: provider.primaryColor,
                activeTrackColor: provider.primaryColor.withOpacity(0.5),
                onChanged: provider.changeTheme,
                value: provider.darkTheme,
              );
            }),
          ),
          ListTile(
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (_) {
                      return Center(
                        child: Container(
                            width: 300,
                            height: 300,
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: GridView.builder(
                                padding: const EdgeInsets.all(10),
                                itemCount: 9,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemBuilder: (c, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Provider.of<ThemeProvider>(context,
                                              listen: false)
                                          .changeMaincolor(index);
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      margin: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: colors[index],
                                      ),
                                    ),
                                  );
                                })),
                      );
                    });
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
              leading:
                  Icon(Icons.brush, color: Theme.of(context).iconTheme.color),
              title: Text(
                'Change main color',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
              ),
              trailing: Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                return Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: themeProvider.primaryColor,
                  ),
                );
              })),
        ],
      )),
    );
  }
}
