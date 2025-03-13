import 'package:dartz/dartz.dart';
import 'package:ronfltapp/data/models/song/song.dart';
import 'package:ronfltapp/data/sources/song/song_firebase_service.dart';
import 'package:ronfltapp/domain/entities/song/song.dart';
import 'package:ronfltapp/domain/repository/song/song.dart';

import '../../../service_locator.dart';

class SongRepositoryImpl extends SongsRepository{
  @override
  Future<Either> getNewsSongs() async {
 return sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() {
    return sl<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) {
    return sl<SongFirebaseService>().addOrRemoveFavoriteSong(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) {
    return sl<SongFirebaseService>().isFavoriteSong(songId);
  }

  @override
  Future<Either> getFavoriteSongs() {
    return sl<SongFirebaseService>().getFavoriteSongs();
  }




}