import 'package:dartz/dartz.dart';
import 'package:ronfltapp/data/models/auth/create_user_req.dart';
import 'package:ronfltapp/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';
import '../usercase.dart';

class SignupUseCase extends UseCase<Either,CreateUserReq>{
  @override
  Future<Either> call(CreateUserReq createuserreq) async {
    return sl<AuthRepository>().signup(createuserreq);
  }

}