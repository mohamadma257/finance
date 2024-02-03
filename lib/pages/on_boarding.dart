import 'package:finance/colors/colors.dart';
import 'package:finance/pages/home.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pageController = PageController();
  int currentIndex = 0;
  bool isLastPage = false;
  List<PageItem> item = [
    PageItem(
      title: "Title 1",
      subTitle: "Sub Title 1",
      image: 'assets/images/finance1.png',
    ),
    PageItem(
      title: "Title 2",
      subTitle: "Sub Title 2",
      image: 'assets/images/finance2.png',
    ),
    PageItem(
      title: "Title 3",
      subTitle: "Sub Title 3",
      image: 'assets/images/finance3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => false);
              },
              child: Text("Skip"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                  if (value + 1 == item.length) {
                    setState(() {
                      isLastPage = true;
                    });
                  } else {
                    setState(() {
                      isLastPage = false;
                    });
                  }
                },
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return item[index];
                },
                controller: pageController,
              ),
            ),
            Row(
              children: [
                Text("${currentIndex + 1}/${item.length}"),
                Spacer(),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isLastPage ? kPrimaryGreen : kPrimaryBlue,
                        foregroundColor: kWhiteColor),
                    onPressed: () {
                      isLastPage
                          ? Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (route) => false)
                          : pageController.nextPage(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.bounceInOut);
                    },
                    child: Text(isLastPage ? "Get Started" : "Next"))
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class PageItem extends StatelessWidget {
  final String title;
  final String image;
  final String subTitle;

  const PageItem({
    super.key,
    required this.title,
    required this.image,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image.asset(image)),
        Text(
          title,
          style: TextStyle(
            color: kPrimaryGreen,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(subTitle),
      ],
    );
  }
}
