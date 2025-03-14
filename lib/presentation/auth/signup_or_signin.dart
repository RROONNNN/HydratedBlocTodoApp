import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ronfltapp/common/helper/is_dark_mode.dart';
import 'package:ronfltapp/common/widgets/button/basic_app_button.dart';
import 'package:ronfltapp/presentation/auth/signin.dart';
import 'package:ronfltapp/presentation/auth/signup.dart';

import '../../common/widgets/appbar/app_bar.dart';
import '../../core/configs/assets/app_vectors.dart';
import '../../core/configs/theme/app_colors.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:Stack(
        children: [
          BasicAppBar(hideBack: false,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset('assets/images/auth_bg.png')
            ),
          Align(
            alignment: Alignment.topRight,
            child:SvgPicture.asset(AppVectors.topPattern)
            ),
          Align(
              alignment: Alignment.bottomRight,
              child:SvgPicture.asset(AppVectors.bottomPattern)
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.logo),
                  const SizedBox(height: 30,),
                  Text('Enjoy Listening To Music',style:TextStyle(fontWeight: FontWeight.bold,
                      color: AppColors.darkGrey,
                      fontSize: 24),),
                  const SizedBox(height: 20,),
                  Text(
                    'Spotify is a proprietary Swedish audio streaming and media services provider ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: AppColors.grey
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                          child: BasicAppButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUpPage()));
                          }, title: 'Register')),
                      SizedBox(width: 20,),
                      Expanded(
                          child: TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>SigninPage()));
                          }, child: Text('Sign in',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color:context.isDarkMode?Colors.white:AppColors.darkGrey,
                            )

                            ,))),
                    ],
                  ),
                  SizedBox(height: 30,),

                ],
              ),
            ),
          )

        ],

      ),
    );
  }
}
//