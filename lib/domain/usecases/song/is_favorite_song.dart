import 'package:dartz/dartz.dart';
import 'package:ronfltapp/data/repository/song/song_repository_impl.dart';

import '../../../core/usecase/usercase.dart';
import '../../../service_locator.dart';

class IsFavoriteSongUseCase extends UseCase<bool,String>{
  @override
  Future<bool> call(params) {
    return sl<SongRepositoryImpl>().isFavoriteSong(params);
  }

}