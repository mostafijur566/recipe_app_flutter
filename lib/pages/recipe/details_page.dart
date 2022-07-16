import 'package:flutter/material.dart';
import 'package:recipe_app_flutter/utils/app_colors.dart';
import 'package:recipe_app_flutter/utils/app_constants.dart';
import 'package:recipe_app_flutter/utils/dimensions.dart';
import 'package:recipe_app_flutter/widgets/app_icon.dart';
import 'package:recipe_app_flutter/widgets/big_text.dart';
import 'package:recipe_app_flutter/widgets/small_text.dart';

import '../../widgets/expandable_text_widget.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.height70,
            title:  AppIcon(icon: Icons.clear),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height20),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10),
                width: double.maxFinite,
                child: Center(
                  child: BigText(
                    text: 'Chicken',
                    size: Dimensions.font26,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  )
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: Dimensions.height300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                  'assets/images/chicken.jpg',
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
            left: Dimensions.height20, right: Dimensions.height20,
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: 'Ingredients', size: Dimensions.font26, color: AppColors.mainColor,),
                      SizedBox(height: Dimensions.height10,),
                      SmallText(text: AppConstants.ingredints, size: Dimensions.font18, color: AppColors.paraColor,),
                      SizedBox(height: Dimensions.height20,),
                      BigText(text: 'Preparation', size: Dimensions.font26, color: AppColors.mainColor,),
                      SizedBox(height: Dimensions.height10,),
                      SmallText(text: AppConstants.preparation, size: Dimensions.font18, color: AppColors.paraColor,),
                      SizedBox(height: Dimensions.height20,),
                    ],
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
