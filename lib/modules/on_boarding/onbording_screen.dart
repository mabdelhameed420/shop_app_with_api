import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/style/color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/on_boarding_model/on_boarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> pages = [
    BoardingModel(
        image: 'assets/images/istockphoto-1211706628-612x612 - Copy.jpg',
        title: 'title 1',
        body: 'body 1'),
    BoardingModel(
        image: 'assets/images/grocery-shopping-app-smartphone - Copy.jpg',
        title: 'title 2',
        body: 'body 2'),
    BoardingModel(
        image: 'assets/images/grocery-shopping-app-smartphone - Copy.jpg',
        title: 'title 3',
        body: 'body 3'),
  ];

  var boardController = PageController();

  bool isLast = false;

  void submit(){
    CachedHelper.putData(key: 'onBoarding', value: true).then((value) {
      if(value) {
        navigateWithoutBack(context, const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  submit();
                },
                child: const Text('skip')),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == pages.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  controller: boardController,
                  itemBuilder: (context, index) =>
                      itemPageBuilder(pages[index]),
                  itemCount: pages.length,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: pages.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: defaultColor,
                      dotWidth: 10,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 3,
                      spacing: 5,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 700,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    backgroundColor: defaultColor,
                    child: const Icon(Icons.arrow_forward_ios),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget itemPageBuilder(BoardingModel model) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Image(image: AssetImage(model.image))),
        const SizedBox(height: 30),
        Text(
          model.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 30),
        Text(
          model.body,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ]);
}
