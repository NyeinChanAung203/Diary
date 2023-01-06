import 'package:diary/widgets/homeScreen/custom_appbar.dart';
import 'package:diary/widgets/onboarding/make_profile.dart';
import 'package:flutter/material.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          CustomAppBar(
              title: Text('Edit Profile',
                  style: Theme.of(context).textTheme.titleLarge)),
          Expanded(
            child: ListView(
              children: const [
                SizedBox(
                  height: 20,
                ),
                MakeProfileScreen(
                  isEdit: true,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
