import 'package:dartz/dartz.dart';
import 'package:ronfltapp/data/models/auth/create_user_req.dart';

import '../../../core/usecase/usercase.dart';
import '../../../service_locator.dart';
import '../../repository/auth/auth.dart';

class SignupUseCase extends UseCase<Either,CreateUserReq>{
  @override
  Future<Either> call(CreateUserReq params)  async{
   return await sl<AuthRepository>().signup(params);
  }
  
}