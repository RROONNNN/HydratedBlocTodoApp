import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ronfltapp/domain/entities/song/song.dart';

class SongModel{
  String? artist;
  num? duration;
  Timestamp? releaseDate;
   String? title;
  bool ? isFavorite;
  String ? songId;
  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
    required this.songId
  });
  SongModel.fromJson(Map<String,dynamic> json){
    title=json['title'];
    artist=json['artist'];
    duration=json['duration'];
    releaseDate=json['releaseDate'];
  }

}
extension SongModelX on SongModel {

  SongEntity toEntity() {
    return SongEntity(
        title: title!,
        artist: artist!,
        duration: duration!,
        releaseDate: releaseDate!,
        isFavorite: isFavorite!,
        songId: songId!
    );
  }
}