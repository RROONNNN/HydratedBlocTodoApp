import 'package:dartz/dartz.dart';

import '../../../data/models/song/song.dart';
import '../../entities/song/song.dart';

abstract class SongsRepository{
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSong(String songId);
  Future<bool>  isFavoriteSong(String songId);
  Future<Either> getFavoriteSongs();

}