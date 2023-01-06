import 'dart:io';
import 'dart:typed_data';

import 'package:diary/database/hive_database.dart';
import 'package:diary/models/user_profile_model.dart';
import 'package:diary/providers/user_provider.dart';
import 'package:diary/routes/routes.dart';
import 'package:diary/utils/constants.dart';
import 'package:diary/widgets/onboarding/ppinputfield.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class MakeProfileScreen extends StatefulWidget {
  const MakeProfileScreen({
    Key? key,
    required this.isEdit,
  }) : super(key: key);

  final bool isEdit;

  @override
  State<MakeProfileScreen> createState() => _MakeProfileScreenState();
}

class _MakeProfileScreenState extends State<MakeProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final DbHelper _dbHelper = DbHelper.instance();
  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      userProfile = _dbHelper.getUserProfile();
      _nameController.text = userProfile!.name;
      _genderController.text = userProfile!.gender;
      _dateController.text = DateFormat.yMd().format(userProfile!.dateOfBirth);
      _uint8list = userProfile?.pic;
    } else {
      _dateController.text = DateFormat.yMd().format(DateTime(2000));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _dateController.dispose();
    imageFile.dispose();
    super.dispose();
  }

  // File? imageFile;
  ValueNotifier<File?> imageFile = ValueNotifier(null);
  Uint8List? _uint8list;

  final ImagePicker _picker = ImagePicker();

  _getFromGallery() async {
    PickedFile? pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      // maxWidth: 1800,
      // maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      _uint8list = imageFile.value!.readAsBytesSync();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(children: [
          /* Profile Pic */
          GestureDetector(
            onTap: _getFromGallery,
            child: Stack(children: [
              ValueListenableBuilder(
                  valueListenable: imageFile,
                  builder: (context, File? img, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Container(
                        decoration: const BoxDecoration(
                          // color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        width: 150,
                        height: 150,
                        child: widget.isEdit && _uint8list != null
                            ? Image.memory(
                                _uint8list!,
                                fit: BoxFit.cover,
                              )
                            : img == null
                                ? Stack(
                                    alignment: Alignment.center,
                                    children: const [
                                      CircleAvatar(
                                        radius: 80,
                                        backgroundColor: avatarBgColor,
                                        child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: primaryTextColor),
                                      ),
                                      Positioned(
                                        bottom: -45,
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundColor: primaryTextColor,
                                        ),
                                      ),
                                    ],
                                  )
                                : Image.file(
                                    img,
                                    fit: BoxFit.cover,
                                  ),
                      ),
                    );
                  }),
              const Positioned(
                  bottom: 3,
                  right: 3,
                  child: CircleAvatar(
                    radius: 18,
                    child: Icon(Icons.camera_alt_outlined),
                  )),
            ]),
          ),

          /* Name Field */
          PpInputField(
            title: 'Name',
            hintText: "Enter your name",
            isTextField: true,
            isDateField: false,
            isGenderField: false,
            nameController: _nameController,
          ),
          /* Date Field */
          PpInputField(
            title: 'Date of birth',
            hintText: "Enter your name",
            isTextField: false,
            isDateField: true,
            selectedDate: userProfile?.dateOfBirth,
            isGenderField: false,
            dateController: _dateController,
          ),

          /* Gender Field */
          PpInputField(
            title: 'Gender',
            hintText: "Select your gender",
            isTextField: false,
            isDateField: false,
            isGenderField: true,
            genderController: _genderController,
          ),
          const SizedBox(
            height: 30,
          ),
          widget.isEdit
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style!
                          .copyWith(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.primary,
                              ),
                              side: MaterialStateProperty.all(
                                BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              )),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<UserProvider>().updateUserProfile(
                              _nameController.text,
                              _dateController.text,
                              _genderController.text,
                              _uint8list);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Save')),
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      UserProfile user = UserProfile(
                        name: _nameController.text,
                        dateOfBirth:
                            DateFormat.yMd().parse(_dateController.text),
                        gender: _genderController.text,
                        pic: _uint8list,
                        created: DateTime.now(),
                      );

                      _dbHelper.createUserProfile(user);

                      Navigator.of(context).pushReplacementNamed(Routes.home);
                    }
                  },
                  child: const Text('Get Started')),
        ]),
      ),
    );
  }
}
