import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ronfltapp/common/helper/is_dark_mode.dart';
import 'package:ronfltapp/common/widgets/appbar/app_bar.dart';
import 'package:ronfltapp/common/widgets/button/basic_app_button.dart';
import 'package:ronfltapp/core/configs/assets/app_vectors.dart';
import 'package:ronfltapp/core/configs/theme/app_colors.dart';
import 'package:ronfltapp/domain/usecases/auth/signin.dart';
import 'package:ronfltapp/presentation/auth/signin.dart';
import 'package:ronfltapp/presentation/auth/signup.dart';
import 'package:ronfltapp/presentation/root/root.dart';

import '../../data/models/auth/signin_user_req.dart';
import '../../service_locator.dart';

class SigninPage extends StatelessWidget {
   SigninPage({super.key}){
     _email.text='ttt@gmail.com';
      _password.text='0123456';
   }
   final TextEditingController _email=TextEditingController();
    final TextEditingController _password=TextEditingController();
  Widget _accountField(BuildContext  context){
    return TextField(
      controller: _email,
      decoration: InputDecoration(
        hintText: 'Enter your Username or Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
  Widget _passwordField(BuildContext context){
    return TextField(
      controller: _password,
      decoration: InputDecoration(
        hintText: 'Password',
      ).applyDefaults(
          Theme.of(context).inputDecorationTheme
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(hideBack: false,title: SvgPicture.asset(AppVectors.logo,height: 40,),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Sign In',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color:context.isDarkMode?AppColors.grey:AppColors.darkGrey)),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('If You Need Any Support',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                    TextButton(onPressed: (){}, child: Text('Click Here',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: AppColors.primary),))
                  ],
                ),
                SizedBox(height: 20,),
                _accountField(context),
                SizedBox(height: 20,),
                _passwordField(context),
                SizedBox(height: 20,),
                BasicAppButton(onPressed: () async {
                var result=await sl<SigninUseCase>().call(SigninUserReq(email: _email.text,password: _password.text));
                result.fold((l){
var snack=SnackBar(content: Text(l.toString()),backgroundColor: Colors.red,);
ScaffoldMessenger.of(context).showSnackBar(snack);
                }, (r){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=> const RootPage()), (route) => false);
                });

                }, title: "Sign In"),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text("Recovery Password",style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not A Member ?",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()
                      ));
                    }, child: Text("Register Now",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color:Colors.blue),))
                  ],
                )
              ],
            )
        ),
      ),
    );
  }

}
