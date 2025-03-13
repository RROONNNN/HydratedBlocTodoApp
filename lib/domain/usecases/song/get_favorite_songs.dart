import 'package:dartz/dartz.dart';

import '../../../core/usecase/usercase.dart';
import '../../../service_locator.dart';
import '../../repository/song/song.dart';

class GetFavoriteSongsUseCase  extends UseCase<Either,dynamic>{
  @override
  Future<Either> call(params) async{
    return await sl<SongsRepository>().getFavoriteSongs();
  }

  
}