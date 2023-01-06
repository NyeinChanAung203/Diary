import 'package:diary/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SkipAndPageIndicator extends StatelessWidget {
  const SkipAndPageIndicator({
    Key? key,
    required this.isLastPage,
    required PageController controller,
  })  : _controller = controller,
        super(key: key);

  final bool isLastPage;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 25,
      // padding: const EdgeInsets.only(bottom: 30),
      child: Stack(
        alignment: Alignment.center,
        children: [
          !isLastPage
              ? Positioned(
                  left: 30,
                  child: TextButton(
                    child: Text(
                      'Skip',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: primaryColor),
                    ),
                    onPressed: () {
                      _controller.animateToPage(2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linearToEaseOut);
                    },
                  ))
              : const SizedBox(),
          Positioned(
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: const SlideEffect(
                  spacing: 8.0,
                  radius: 10.0,
                  dotWidth: 16.0,
                  dotHeight: 16.0,
                  dotColor: inActiveColor,
                  activeDotColor: primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
