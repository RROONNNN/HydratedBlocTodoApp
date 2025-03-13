import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ronfltapp/presentation/profile/bloc/profile_infor_state.dart';

import '../../../domain/usecases/auth/get_user.dart';
import '../../../service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState>{
  ProfileInfoCubit(): super(ProfileInfoLoading());

  void loadProfileInfo() async {
    var user = await sl<GetUserUseCase>().call(null);
    user.fold((l) => emit(ProfileInfoFailure()), (r) => emit(ProfileInfoLoaded(r)));

  }

}