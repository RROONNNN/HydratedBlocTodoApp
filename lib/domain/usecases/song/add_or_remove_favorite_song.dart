import 'package:dartz/dartz.dart';
import 'package:ronfltapp/domain/entities/song/song.dart';

import '../../../core/usecase/usercase.dart';
import '../../../data/repository/song/song_repository_impl.dart';
import '../../../service_locator.dart';

class AddOrRemoveFavoriteSongUsecase extends UseCase<Either,dynamic>{
  @override
  Future<Either> call(params) {
return sl<SongRepositoryImpl>().addOrRemoveFavoriteSong(params);
  }
}
