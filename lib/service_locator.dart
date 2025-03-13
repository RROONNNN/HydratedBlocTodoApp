import 'package:get_it/get_it.dart';
import 'package:ronfltapp/core/usecase/auth/signup.dart';
import 'package:ronfltapp/data/models/auth/signin_user_req.dart';
import 'package:ronfltapp/data/repository/auth/auth_repository_impl.dart';
import 'package:ronfltapp/data/repository/song/song_repository_impl.dart';
import 'package:ronfltapp/data/sources/auth/auth_firebase_service.dart';
import 'package:ronfltapp/data/sources/song/song_firebase_service.dart';
import 'package:ronfltapp/domain/repository/auth/auth.dart';
import 'package:ronfltapp/domain/repository/song/song.dart';
import 'package:ronfltapp/domain/usecases/auth/signin.dart';
import 'package:ronfltapp/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:ronfltapp/domain/usecases/song/get_new_song.dart';
import 'package:ronfltapp/domain/usecases/song/get_play_list_song.dart';
import 'package:ronfltapp/domain/usecases/song/is_favorite_song.dart';
import 'package:ronfltapp/presentation/profile/bloc/profile_infor_cubit.dart';

import 'domain/usecases/auth/get_user.dart';
import 'domain/usecases/song/get_favorite_songs.dart';

final sl=GetIt.instance;
Future<void> initilizeDependencies() async{
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );

  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );
  sl.registerSingleton<SigninUseCase>(
      SigninUseCase()
  );
  sl.registerSingleton<AddOrRemoveFavoriteSongUsecase>(
      AddOrRemoveFavoriteSongUsecase()
  );
  sl.registerSingleton<IsFavoriteSongUseCase>(
      IsFavoriteSongUseCase()
  );
  sl.registerSingleton<SongFirebaseService>(
      SongFirebaseServiceImpl()
  );
  sl.registerSingleton<SongsRepository>(
      SongRepositoryImpl()
  );
  sl.registerSingleton<SongRepositoryImpl>(
      SongRepositoryImpl()
  );
  sl.registerSingleton<GetNewsSongsUseCase>(
      GetNewsSongsUseCase()
  );
  sl.registerSingleton<GetPlayListSongs>(
      GetPlayListSongs()
  );
  sl.registerSingleton<GetUserUseCase>(
      GetUserUseCase()
  );
  sl.registerSingleton<ProfileInfoCubit>(
      ProfileInfoCubit()
  );
  sl.registerSingleton<GetFavoriteSongsUseCase>(
      GetFavoriteSongsUseCase()
  );
}