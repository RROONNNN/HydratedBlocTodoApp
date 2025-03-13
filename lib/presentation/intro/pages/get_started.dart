import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ronfltapp/core/configs/assets/app_images.dart';

import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../choose_mode/pages/choose_mode.dart';

class GetStartedPage  extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         Container(

            decoration: BoxDecoration(
              image: DecorationImage(
                image:  AssetImage(AppImages.introBG),
                fit: BoxFit.fill,
              ),
            ),
         ),
   Padding(
     padding:EdgeInsets.all(25),
     child: Center(
       child: Column(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SvgPicture.asset(AppVectors.logo),
        ),
        Column(
          children: [
           Padding(padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
           child: Column(
             children: [
               Text("Enjoy Listening To Music",style: TextStyle(fontWeight: FontWeight.bold,
                   color: Colors.white,
                   fontSize: 18),
               textAlign: TextAlign.center),
               const SizedBox(height: 20,),
               Text(
                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                 style: TextStyle(
                     fontWeight: FontWeight.w500,
                     color: AppColors.grey,
                     fontSize: 14
                 ),
                 textAlign: TextAlign.center,
               ),
               const SizedBox(height: 20,),
             ],
           )
           ),
            BasicAppButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const ChooseModePage()
                    )
                );
              },
              title: "Get started",

     
            )
          ],
        )
      ],
       ),
     ),
   )
        ],
      ),
    );
  }
}
