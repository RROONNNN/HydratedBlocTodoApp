import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ronfltapp/domain/usecases/song/get_play_list_song.dart';
import 'package:ronfltapp/presentation/root/bloc/play_list_state.dart';

import '../../../service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {

  PlayListCubit() : super(PlayListLoading());

  Future < void > getPlayList() async {
    var returnedSongs = await sl <GetPlayListSongs> ().call(null);
    returnedSongs.fold(
            (l) {
          emit(PlayListLoadFailure());
        },
            (data) {
          emit(
              PlayListLoaded(songs: data)
          );
        }
    );
  }


}