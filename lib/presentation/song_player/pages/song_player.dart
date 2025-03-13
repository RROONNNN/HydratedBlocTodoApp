import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ronfltapp/common/widgets/appbar/app_bar.dart';
import 'package:ronfltapp/common/widgets/favorite_button/favorite_button.dart';
import 'package:ronfltapp/main.dart';

import '../../../core/configs/constants/app_urls.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/song/song.dart';
import '../bloc/song_player_cubit.dart';
import '../bloc/song_player_state.dart';

class SongPlayer extends StatelessWidget {
  const SongPlayer({super.key, required this.song});
  final SongEntity song;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: BasicAppBar(hideBack: false,
title: Text('Now playing'),
  action: IconButton(
    icon: Icon(Icons.more_vert_rounded), onPressed: () {  },
  ),

),
      body:BlocProvider(

        create: (context) => SongPlayerCubit()..playSong( '${AppUrls.songFirestorage}${song.artist} - ${song.title}.mp3?${AppUrls.mediaAlt}'),
        child: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child:
              Column(
                children: [
                  _songCover(context),
                  _songInfo(),
                  _songPlayer(context),
                ],
              )
          ),
        ),
      )
    );
  }
  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  '${AppUrls.coverFirestorage}${song.artist} - ${song.title}.jpg?${AppUrls.mediaAlt}'
              )
          )
      ),
    );
  }
  Widget _songInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(song.title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),
            ),
            Text(song.artist,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey
              ),
            ),

          ],
        ),
        FavoriteButton(  song: song,),
      ],
    );
  }
  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit,SongPlayerState>(
      builder: (context, state) {
        if(state is SongPlayerLoading){
          return const CircularProgressIndicator();
        }
        if(state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                  value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                  min: 0.0,
                  max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble() ,
                  onChanged: (value){
                    context.read<SongPlayerCubit>().songPosition = Duration(seconds: value.toInt());
                    context.read<SongPlayerCubit>().audioPlayer.seek(Duration(seconds: value.toInt()));
                  }
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      formatDuration(
                          context.read<SongPlayerCubit>().songPosition
                      )
                  ),

                  Text(
                      formatDuration(
                          context.read<SongPlayerCubit>().songDuration
                      )
                  )
                ],
              ),
              const SizedBox(height: 20,),

              GestureDetector(
                onTap: (){
                  context.read<SongPlayerCubit>().playOrPause();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary
                  ),
                  child: Icon(
                      context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause : Icons.play_arrow
                  ),
                ),
              )
            ],
          );
        }

        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }

}
