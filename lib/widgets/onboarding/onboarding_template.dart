import 'package:diary/utils/constants.dart';
import 'package:flutter/material.dart';

class OnBoardingTemplate extends StatelessWidget {
  const OnBoardingTemplate({
    Key? key,
    required this.title,
    this.content,
    this.subTitle,
    this.coverImage,
  }) : super(key: key);

  final String title;
  final String? subTitle;
  final Widget? content;
  final Widget? coverImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              /* Background box decoration */
              Positioned(
                top: 10,
                right: 0,
                child: Container(
                  width: 200,
                  height: 200,
                  transform: Matrix4.rotationZ(12),
                  decoration: BoxDecoration(
                    color: boxColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                right: 0,
                child: Container(
                  width: 80,
                  height: 80,
                  transform: Matrix4.rotationZ(12),
                  decoration: BoxDecoration(
                    color: boxColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Positioned(
                top: -10,
                right: 30,
                child: Container(
                  width: 100,
                  height: 100,
                  transform: Matrix4.rotationZ(12),
                  decoration: BoxDecoration(
                    color: boxColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              /* Headline Title */
              Positioned(
                left: 30,
                top: 40,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(title,
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
              ),

              /* Content */
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 600,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          // color: Colors.purple,
                          margin: coverImage != null
                              ? const EdgeInsets.only(bottom: 50, top: 50)
                              : const EdgeInsets.all(0),
                          child: coverImage ?? const SizedBox()),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(subTitle ?? '',
                                style: Theme.of(context).textTheme.titleMedium),
                          ),
                        ),
                      ),
                      content ?? const SizedBox()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
