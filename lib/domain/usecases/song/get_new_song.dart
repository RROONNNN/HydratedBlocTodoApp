import 'package:dartz/dartz.dart';
import 'package:ronfltapp/data/models/song/song.dart';
import 'package:ronfltapp/data/repository/song/song_repository_impl.dart';

import '../../../core/usecase/usercase.dart';
import '../../../service_locator.dart';

class GetNewsSongsUseCase extends UseCase<Either,dynamic>{
  @override
  Future<Either> call(params) async {
 return await sl<SongRepositoryImpl>().getNewsSongs();
  }

}

