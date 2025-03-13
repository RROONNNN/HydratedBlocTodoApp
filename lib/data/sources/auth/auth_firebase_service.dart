import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ronfltapp/core/configs/constants/app_urls.dart';
import 'package:ronfltapp/data/models/auth/create_user_req.dart';

import '../../../domain/entities/auth/user.dart';
import '../../models/auth/signin_user_req.dart';
import '../../models/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createuserreq);
  Future<Either> signin(SigninUserReq signinUserReq);
  Future<Either> getUser();
}
class AuthFirebaseServiceImpl extends AuthFirebaseService{
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserReq.email, password: signinUserReq.password);
      return  const Right('Signin Successful');

    } on FirebaseAuthException catch (e) {
      String message='';
    if (e.code == 'invalid-email') {
      message = 'The email address is badly formatted.';
    } else if (e.code == 'user-not-found') {
      message = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      message = 'Wrong password provided for that user.';
    }
      return Left(e.message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createuserreq) async {
    try {
     var data= await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createuserreq.email, password: createuserreq.password);
     print("full name:"+createuserreq.fullName);
     FirebaseFirestore.instance.collection('Users').doc(data.user?.uid)
         .set(
         {
           'name' : createuserreq.fullName,
           'email' : data.user?.email,
         }
     );

      return  const Right('User Created');

    } on FirebaseAuthException catch (e) {
      String message='';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
      return Left(e.message);
    }
  }

  @override
  Future<Either> getUser() async{
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = await firebaseFirestore.collection('Users').doc(
          firebaseAuth.currentUser?.uid
      ).get();

      UserModel userModel = UserModel.fromJson(user.data() !);
      userModel.imageURL = firebaseAuth.currentUser?.photoURL ?? AppUrls.defaultImage;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return const Left('An error occurred');
    }
  }

}