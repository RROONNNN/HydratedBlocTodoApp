import 'package:dartz/dartz.dart';

import '../../../core/usecase/usercase.dart';
import '../../../data/repository/song/song_repository_impl.dart';
import '../../../service_locator.dart';

class GetPlayListSongs extends UseCase<Either,dynamic> {
  @override
  Future<Either> call(params) async {
    return await sl<SongRepositoryImpl>().getPlayList();
  }

}