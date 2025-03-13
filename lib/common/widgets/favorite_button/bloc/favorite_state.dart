abstract class FavoriteState {}
class UpdatedFavoriteState extends FavoriteState {
  final bool isFavorite;
  UpdatedFavoriteState({required this.isFavorite});
}
class InitialFavoriteState extends FavoriteState {

}

class FavoriteError extends FavoriteState {

}

