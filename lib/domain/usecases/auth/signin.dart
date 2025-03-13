import 'package:dartz/dartz.dart';
import 'package:ronfltapp/data/models/auth/create_user_req.dart';
import 'package:ronfltapp/data/models/auth/signin_user_req.dart';

import '../../../core/usecase/usercase.dart';
import '../../../service_locator.dart';
import '../../repository/auth/auth.dart';

class SigninUseCase extends UseCase<Either,SigninUserReq>{
  @override
  Future<Either> call(SigninUserReq params)  async{
    return await sl<AuthRepository>().signin(params);
  }

}