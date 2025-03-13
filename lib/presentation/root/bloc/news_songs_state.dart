import '../../../domain/entities/song/song.dart';

abstract class NewsSongsState{

}
class NewsSongsLoading extends NewsSongsState{}
class NewsSongsLoaded extends NewsSongsState{
  final List<SongEntity> songs;
  NewsSongsLoaded(this.songs);
}

class NewsSongsError extends NewsSongsState{

}