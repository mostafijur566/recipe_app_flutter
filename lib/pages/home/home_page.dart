import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app_flutter/utils/app_colors.dart';
import 'package:recipe_app_flutter/utils/dimensions.dart';

import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController pageController = PageController(viewportFraction: 0.85);

  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    print(Dimensions.screenWidth);
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bengali Recipe',
          style: TextStyle(
            color: AppColors.mainColor
          ),
        ),
        //elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: Dimensions.height10),
            height: Dimensions.pageView,
            child: PageView.builder(
              controller: pageController,
                itemCount: 3,
                itemBuilder: (context, position){
                  return _buildPageItem(position);
                }
            ),
          ),

          DotsIndicator(
            dotsCount: 3,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
              )
            ),
          ),

          SizedBox(height: Dimensions.height30,),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: Dimensions.height20),
            child: BigText(text: 'Popular recipes',),
          ),
          SizedBox(height: Dimensions.height10,),

          GridView.builder(
           physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20, bottom: Dimensions.height20),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 250
              ),
              itemCount: 7,
              itemBuilder: (context, index){
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: Dimensions.width150,
                        height: Dimensions.height100,
                        //child: Image.asset('assets/images/chicken.jpg', fit: BoxFit.cover,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.height15),
                          color: Colors.green,
                          image: DecorationImage(
                            image: AssetImage('assets/images/chicken.jpg',),
                            fit: BoxFit.fill
                          )
                        ),
                      ),

                      SizedBox(height: Dimensions.height30,),
                      Flexible(
                          child: BigText(
                              text: 'Chicken Tandori', size: Dimensions.font18,),
                      ),

                      SizedBox(height: Dimensions.height10,),
                      IconAndTextWidget(
                          icon: Icons.access_time_rounded,
                          text: 'Cook time 32min',
                          iconColor: AppColors.iconColor2)
                    ],
                  ),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xFFe8e8e8),
                            blurRadius: 5.0,
                            offset: Offset(0, 5)),
                        BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                      ]
                  ),
                );
              })
        ],
      ),
    );
  }



  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();

    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                right: Dimensions.height10, left: Dimensions.height10, top: Dimensions.height10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/food_dummy.jpg'
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageContainerBox,
              margin: EdgeInsets.only(
                  right: Dimensions.height30,
                  left: Dimensions.height30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.height15,
                    right: Dimensions.height15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: 'Chicken wings', size: Dimensions.font26,),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      children: [
                        const Text('Recommended',
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        SizedBox(
                          width: Dimensions.height30,
                        ),
                        IconAndTextWidget(
                            icon: Icons.access_time_rounded,
                            text: '32min',
                            iconColor: AppColors.iconColor2),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
