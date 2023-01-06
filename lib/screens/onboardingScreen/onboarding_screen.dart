import 'package:diary/routes/routes.dart';

import 'package:diary/widgets/onboarding/make_profile.dart';
import 'package:diary/widgets/onboarding/onboarding_template.dart';
import 'package:diary/widgets/onboarding/skip_pageindicator.dart';

import 'package:flutter/material.dart';

import 'package:diary/utils/asset_image_url.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key, this.pageIndex}) : super(key: key);

  final int? pageIndex;

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();

  ValueNotifier<bool> isLastPage = ValueNotifier(false);

  void removeSkip() {
    if (_controller.page == 2.0) {
      isLastPage.value = true;
    } else {
      isLastPage.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.pageIndex != null) {
      _controller = PageController(initialPage: widget.pageIndex!);
      // _controller.jumpToPage(widget.pageIndex!);
    }
    _controller.addListener(() {
      removeSkip();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    isLastPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: PageView(
                  controller: _controller,
                  children: [
                    OnBoardingTemplate(
                      coverImage: Image.asset(
                        memoriesImage,
                        height: 300,
                      ),
                      title: 'Memories',
                      subTitle: 'Write your days and check your memories.',
                    ),
                    OnBoardingTemplate(
                      coverImage: Image.asset(
                        privacyImage,
                        height: 300,
                      ),
                      title: 'Privacy',
                      subTitle:
                          'We recommend setting a password to keep your diaries private.',
                      content: Padding(
                        padding: const EdgeInsets.only(top: 33),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.passwordSetting);
                            },
                            child: const Text('Set Password')),
                      ),
                    ),
                    const OnBoardingTemplate(
                      title: 'Hey,\nLets Make Your Profile',
                      content: MakeProfileScreen(
                        isEdit: false,
                      ),
                    )
                  ],
                ),
              ),

              /* skip and page indicator */
              ValueListenableBuilder(
                valueListenable: isLastPage,
                builder: (context, bool value, child) {
                  return SkipAndPageIndicator(
                      isLastPage: value, controller: _controller);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
