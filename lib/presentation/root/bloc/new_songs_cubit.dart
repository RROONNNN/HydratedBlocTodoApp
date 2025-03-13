

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ronfltapp/domain/usecases/song/get_new_song.dart';
import 'package:ronfltapp/presentation/root/bloc/news_songs_state.dart';

import '../../../service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit():super(NewsSongsLoading());

Future<void> getNewsSongs() async {
    emit(NewsSongsLoading());
    final result = await sl<GetNewsSongsUseCase>().call(null);
    result.fold((l) => emit(NewsSongsError()), (r) => emit(NewsSongsLoaded(r)));
  }
}
