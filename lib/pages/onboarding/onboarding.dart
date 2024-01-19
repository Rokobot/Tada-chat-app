import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tada/components/methods/methods.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  //Page controller
  final PageController controller = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      if (controller.page!.round() != currentIndex) {
        setState(() {
          currentIndex = controller.page!.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //our onboarding
          Expanded(
            child: PageView(
              controller: controller,
              children: [
                pageViewItems(Colors.white, Icons.add_alert_rounded, 'Welcome'),
                pageViewItems(Colors.white, Icons.adb_sharp, 'Hello to you'),
                pageViewItems(
                    Colors.white, Icons.account_tree_sharp, 'Nice to meet you'),
              ],
            ),
          ),
          //our controller items
          itemControllerBar()
        ],
      ),
    );
  }

  //This widget controlled items
  Widget itemControllerBar() {
    return Container(
      color: Colors.transparent,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            currentIndex != 2
                ? TextButton(
                    onPressed: () {
                      controller.jumpToPage(2);
                    },
                    child: Text(
                      'skip',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      nextScreenNamed(context, '/HomePage');
                    },
                    child: Text(
                      'finish',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
            SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: WormEffect(
                  dotColor: Colors.grey,
                  dotWidth: 25,
                  activeDotColor: Colors.greenAccent),
            ),
            currentIndex == 2.0
                ? Container(
                    width: 49,
                  )
                : IconButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeInCubic);
                    },
                    icon: Icon(
                      Icons.arrow_right_outlined,
                      size: 30,
                    ))
          ],
        ),
      ),
    );
  }

  //This widgets make short functions
  Widget pageViewItems(Color color, IconData icon, String text) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: color,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              icon,
              size: 120,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(text),
          )
        ],
      ),
    );
  }
}
