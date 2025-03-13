import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ronfltapp/common/widgets/favorite_button/bloc/favorite_cubit.dart';
import 'package:ronfltapp/domain/entities/song/song.dart';

import '../../../domain/usecases/song/add_or_remove_favorite_song.dart';
import '../../../service_locator.dart';
import 'bloc/favorite_state.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity song;
  final Function ? function;
  const FavoriteButton({super.key, required this.song, this.function});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteCubit>(
      create: (context) => FavoriteCubit(),
      child: BlocBuilder<FavoriteCubit,FavoriteState>(
        builder: ( context, FavoriteState state) {
          if (state is InitialFavoriteState) {
           return IconButton(onPressed: () async{
             //if favorite add to favorite list else remove from favorite list
             await context.read<FavoriteCubit>().updateFavoriteButton(
                 song.songId!
             );

             print('InitialFavoriteState Button Clicked');


           }, icon: Icon(song.isFavorite! ? Icons.favorite : Icons.favorite_outline_outlined));
          }
          else
        if (state is UpdatedFavoriteState  )
          {
            return IconButton(onPressed: () async{
              //if favorite add to favorite list else remove from favorite list
              await context.read<FavoriteCubit>().updateFavoriteButton(
                  song.songId!
              );
              if (function != null) {
                function!();
              }
              print('UpdatedFavoriteState Button Clicked');
            }, icon: (state.isFavorite==true) ? Icon(Icons.favorite,
              size: 25,):Icon(Icons.favorite_outline_outlined,
              size: 25,)) ;
          }
          return IconButton(onPressed: () async{
            //if favorite add to favorite list else remove from favorite list
            await context.read<FavoriteCubit>().updateFavoriteButton(
                song.songId!
            );

            print('Favorite Button Clicked');


          }, icon: Icon(song.isFavorite! ? Icons.favorite : Icons.favorite_outline_outlined));


        }
      ),

    );
  }
}
