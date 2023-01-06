import 'package:diary/database/hive_database.dart';

import 'package:diary/providers/user_provider.dart';
import 'package:diary/routes/routes.dart';
import 'package:diary/utils/asset_image_url.dart';
import 'package:diary/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DbHelper dbHelper = DbHelper.instance();
    String entries = dbHelper.allDiaries().length.toString();
    dbHelper.countMoods();
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(children: [
        Consumer<UserProvider>(builder: (context, userProvider, child) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.only(top: 10),
            height: 260,
            child: DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* Profile */
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    /**Picture */
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Consumer<UserProvider>(
                        builder: (context, userProvider, child) {
                          return Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: userProvider.userProfile?.pic != null
                                ? Image.memory(
                                    userProvider.userProfile!.pic!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    avatarImage,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                          );
                        },
                      ),
                    ),

                    /* Content */
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  userProvider.userProfile!.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(Routes.profileEdit);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .color!),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Age: ${DateTime.now().year - userProvider.userProfile!.dateOfBirth.year}',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Gender: ${userProvider.userProfile!.gender}',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .color,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              /* Days */
                              Column(
                                children: [
                                  Text(
                                    userProvider.userProfile!.getDays(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .color,
                                        ),
                                  ),
                                  Text(
                                    'Days',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              /* Entrise */
                              Column(
                                children: [
                                  Text(
                                    entries,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .color,
                                        ),
                                  ),
                                  Text(
                                    'Entries',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .color,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ]),

                  /* Tags */
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Text('Tags',
                  //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  //         color: Theme.of(context).textTheme.titleMedium!.color)),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // SizedBox(
                  //   height: 21,
                  //   child: ListView.builder(
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: 8,
                  //       itemBuilder: (context, index) {
                  //         return const TagCard(text: 'interview');
                  //       }),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Moods',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color:
                              Theme.of(context).textTheme.titleMedium!.color)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 25,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: joyfulMoodColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('$joyfulEmoji ${dbHelper.joyfulMood}'),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: happyMoodColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('$happyEmoji ${dbHelper.happyMood}'),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: normalMoodColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('$normalEmoji ${dbHelper.normalMood}'),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: sadMoodColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('$sadEmoji ${dbHelper.sadMood}'),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: angryMoodColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('$angryEmoji ${dbHelper.angryMood}'),
                          ),
                          Container(
                            width: 33,
                            margin: const EdgeInsets.only(right: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xff888888).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${dbHelper.noMood}',
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      )
                      //  ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: 6,
                      //     itemBuilder: (context, index) {
                      //       return Container(
                      //         margin: const EdgeInsets.only(right: 5),
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 5, vertical: 2),
                      //         decoration: BoxDecoration(
                      //           color: angryMoodColor,
                      //           borderRadius: BorderRadius.circular(10),
                      //         ),
                      //         child: const Text('$happyEmoji 1'),
                      //       );
                      //     }),
                      ),

                  /* Menu items */
                ],
              ),
            ),
          );
        }),
        Column(children: [
          ListTile(
            leading: Icon(
              Icons.brush,
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
            title: Text('Theme',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color)),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.theme);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.notifications,
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
            title: Text('Reminder',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color)),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.reminder);
            },
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.backup,
          //     color: Theme.of(context).textTheme.titleMedium!.color,
          //   ),
          //   title: Text('Backup',
          //       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          //           color: Theme.of(context).textTheme.titleMedium!.color)),
          //   onTap: () {
          //     Navigator.of(context).pushNamed(Routes.security);
          //   },
          // ),
          ListTile(
            leading: Icon(
              Icons.security,
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
            title: Text('Security',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color)),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.security);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.star,
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
            title: Text('Starred',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color)),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.starred);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.delete,
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
            title: Text('Deleted diaries',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color)),
            onTap: () {
              Navigator.of(context).pushNamed(Routes.trash);
            },
          ),
        ])
      ]),
    );
  }
}
