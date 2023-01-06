import 'package:diary/database/hive_database.dart';
import 'package:diary/models/password_model.dart';
import 'package:diary/providers/set_password_provider.dart';
import 'package:diary/providers/theme_provider.dart';
import 'package:diary/routes/routes.dart';
import 'package:diary/screens/forgot_password.dart';
import 'package:diary/screens/password_screen.dart';

import 'package:diary/widgets/homeScreen/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DbHelper dbHelper = DbHelper.instance();

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          CustomAppBar(
              title: Text('Security',
                  style: Theme.of(context).textTheme.titleLarge)),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            leading: Icon(Icons.lock, color: Theme.of(context).iconTheme.color),
            title: Text(
              'Password lock',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
            ),
            trailing: ValueListenableBuilder(
              valueListenable: dbHelper.passwordBox.listenable(),
              builder: (context, Box<PasswordModel> box, child) {
                return Switch(
                  activeColor: context.watch<ThemeProvider>().primaryColor,
                  activeTrackColor: context
                      .watch<ThemeProvider>()
                      .primaryColor
                      .withOpacity(0.5),
                  onChanged: (value) {
                    var pm = dbHelper.getPasswordModel();
                    if (pm == null) {
                      Navigator.of(context)
                          .pushNamed(Routes.passwordSetting, arguments: false);
                    } else {
                      box.values.last.islock = value;
                      box.values.last.save();
                    }
                  },
                  value:
                      Provider.of<SetPasswordProvider>(context, listen: false)
                              .isLock() ??
                          false,
                );
              },
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            leading:
                Icon(Icons.password, color: Theme.of(context).iconTheme.color),
            title: Text(
              'Change password',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              var pm = dbHelper.getPasswordModel();
              if (pm == null) {
                Navigator.of(context)
                    .pushNamed(Routes.passwordSetting, arguments: false);
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PasswordScreen(
                          isChangePassword: true,
                        )));
              }
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            leading: Icon(Icons.key, color: Theme.of(context).iconTheme.color),
            title: Text(
              'Set up security question',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              var pm = dbHelper.getPasswordModel();
              if (pm == null) {
                Navigator.of(context)
                    .pushNamed(Routes.passwordSetting, arguments: false);
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(
                          isChangeQues: true,
                        )));
              }
            },
          ),
        ],
      )),
    );
  }
}
