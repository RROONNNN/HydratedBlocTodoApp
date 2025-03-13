import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../auth/signup_or_signin.dart';
import '../../splash/bloc/theme_cubit.dart';

class ChooseModePage  extends StatelessWidget {
  const ChooseModePage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:  AssetImage(AppImages.chooseModeBG),
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
                      Padding(padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text("Choose Mode",style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),),
                              const SizedBox(height: 20,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Column(
                                   children: [
                                     GestureDetector(
                         onTap: () {
                           context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                                   },
                                       child: ClipOval(
                                         child: BackdropFilter(filter:ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                                           child: Container(
                                             height: 80,
                                             width: 80,
                                             decoration: BoxDecoration(
                                                 color: const Color(0xff30393C).withOpacity(0.5),
                                                 shape: BoxShape.circle
                                             ),
                                             child: SvgPicture.asset(
                                               AppVectors.moon,
                                               fit: BoxFit.none,
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                     const SizedBox(height: 15,),
                                     const Text(
                                       'Dark Mode',
                                       style: TextStyle(
                                           fontWeight: FontWeight.w500,
                                           fontSize: 15,
                                           color: AppColors.grey
                                       ),
                                     )
                                   ],
                                 ),

                                 Column(
                                   children: [

                                     GestureDetector(
                                   onTap: () {
                                       context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                                              },
                                       child: ClipOval(
                                         child: BackdropFilter(filter:ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                                           child: Container(
                                             height: 80,
                                             width: 80,
                                             decoration: BoxDecoration(
                                                 color: const Color(0xff30393C).withOpacity(0.5),
                                                 shape: BoxShape.circle
                                             ),
                                             child: SvgPicture.asset(
                                               AppVectors.sun,
                                               fit: BoxFit.none,
                                             ),
                                           ),
                                         ),
                                       ),
                                     ),
                                     const SizedBox(height: 15,),
                                     const Text(
                                       'Light Mode',
                                       style: TextStyle(
                                           fontWeight: FontWeight.w500,
                                           fontSize: 15,
                                           color: AppColors.grey
                                       ),
                                     )
                                   ],
                                 ),
                               ],
                             ),
                              const SizedBox(height: 50,),
                            ],
                          )
                      ),
                      BasicAppButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => const SignupOrSigninPage()
                              )
                          );
                        },
                        title: "Continue",

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
