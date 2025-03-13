import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ronfltapp/common/helper/is_dark_mode.dart';
import 'package:ronfltapp/common/widgets/appbar/app_bar.dart';
import 'package:ronfltapp/common/widgets/button/basic_app_button.dart';
import 'package:ronfltapp/core/configs/assets/app_vectors.dart';
import 'package:ronfltapp/core/configs/theme/app_colors.dart';
import 'package:ronfltapp/core/usecase/auth/signup.dart';
import 'package:ronfltapp/data/models/auth/create_user_req.dart';
import 'package:ronfltapp/presentation/auth/signin.dart';
import 'package:ronfltapp/presentation/root/root.dart';

import '../../service_locator.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});
  final TextEditingController _fullName=TextEditingController();
  final TextEditingController _email=TextEditingController();
  final TextEditingController _password=TextEditingController();
  Widget _fullNameOrEmailField(BuildContext  context,String hintText){
    return TextField(
      controller: hintText=='Full Name'?_fullName:_email,
    decoration: InputDecoration(
        hintText: hintText,
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
              Text('Register',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color:context.isDarkMode?AppColors.grey:AppColors.darkGrey)),
              SizedBox(height: 20,),
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('If You Need Any Support',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
               TextButton(onPressed: (){}, child: Text('Click Here',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: AppColors.primary),))
                ],
              ),
              SizedBox(height: 20,),
              _fullNameOrEmailField(context,'Full Name'),
              SizedBox(height: 20,),
              _fullNameOrEmailField(context,'Email'),
              SizedBox(height: 20,),
              _passwordField(context),
              SizedBox(height: 20,),
             BasicAppButton(onPressed: () async {
               var result=await sl<SignupUseCase>().call(
                 CreateUserReq(fullName: _fullName.text.toString(),
                     email: _email.text.toString(),
                     password: _password.text.toString())
               );
               result.fold((l){
                 var snackbar=SnackBar(content: Text(l.toString()),backgroundColor: Colors.red,);
                 ScaffoldMessenger.of(context).showSnackBar(snackbar);
               }, (r){
                   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=>const RootPage()), (route) => false);
               });
             }, title: "Creat Account"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Do You Have An Account?",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                TextButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigninPage()
                  ));
                }, child: Text("Sign In",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color:Colors.blue),))

                ],
              )
            ],
          )
        ),
      ),
    );
  }

}
