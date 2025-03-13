import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ronfltapp/common/widgets/favorite_button/bloc/favorite_state.dart';
import 'package:ronfltapp/domain/entities/song/song.dart';

import '../../../../domain/usecases/song/add_or_remove_favorite_song.dart';
import '../../../../service_locator.dart';

class FavoriteCubit extends Cubit<FavoriteState>{
  FavoriteCubit():super(InitialFavoriteState());

  Future<void> updateFavoriteButton(String songid) async {
    final result = await sl<AddOrRemoveFavoriteSongUsecase>().call(songid);
    result.fold((l) => emit(FavoriteError()), (r){
    return emit (UpdatedFavoriteState( isFavorite: r));
    });
  }
}