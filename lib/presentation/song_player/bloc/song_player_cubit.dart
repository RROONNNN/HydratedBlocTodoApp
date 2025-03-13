import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ronfltapp/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState>{
  SongPlayerCubit(): super(SongPlayerLoading()){
    audioPlayer.positionStream.listen((event) {
      songPosition = event;
      emit(SongPlayerLoaded());
    });
    audioPlayer.durationStream.listen((event) {
      songDuration = event!;
      emit(SongPlayerLoaded());
    });
  }
  AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  Future<void> playSong(String url) async{
    try{
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoaded());

    }catch (e){
      SongPlayerFailure();
    }
  }
Future<void> playOrPause() async{
if (audioPlayer.playing){
  audioPlayer.stop();
}
else {
  audioPlayer.play();
}
emit(SongPlayerLoaded());
  }
@override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();

  }
}