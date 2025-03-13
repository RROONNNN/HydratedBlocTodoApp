import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ronfltapp/common/helper/is_dark_mode.dart';
import 'package:ronfltapp/core/configs/constants/app_urls.dart';
import 'package:ronfltapp/domain/entities/song/song.dart';
import 'package:ronfltapp/presentation/root/bloc/new_songs_cubit.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../song_player/pages/song_player.dart';
import '../bloc/news_songs_state.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) =>NewsSongsCubit()..getNewsSongs(),
    child: SizedBox(
child:BlocBuilder<NewsSongsCubit,NewsSongsState>(builder: (BuildContext context, NewsSongsState state) {
    if(state is NewsSongsLoading){
    return const Center(child: CircularProgressIndicator(),);
    }
    else if (state is NewsSongsLoaded){
    return _songs(state.songs);
    }
    else{
    return const Center(child: Text('Error'),);
          }
        },
    )
    ),
    );
  }
  Widget _songs(List<SongEntity> songs){
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: ListView.separated(itemBuilder: (BuildContext context, int index) {
         return GestureDetector(
           onTap: (){
             Navigator.push(context ,MaterialPageRoute(builder: (context) => SongPlayer(song: songs[index],)));
           },
           child: SizedBox(
             width: 120,

             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Expanded(
                     child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                            height: 160,
                           width: 120,
                           decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: NetworkImage( '${AppUrls.coverFirestorage}${songs[index].artist} - ${songs[index].title}.jpg?${AppUrls.mediaAlt}'
                                        ),
                                        fit: BoxFit.cover
                                        ),
                                        ),
                           child: Align(
                             alignment: Alignment.bottomRight,
                             child: Container(
                               height: 30,
                               width: 30,
                               transform: Matrix4.translationValues(-10, 10, 0),
                               decoration: BoxDecoration(
                                   shape: BoxShape.circle,
                                   color: context.isDarkMode ?  AppColors.darkGrey : const Color(0xffE6E6E6)
                               ),
                               child: Icon(
                                 Icons.play_arrow_rounded,
                                 color: context.isDarkMode ? const Color(0xff959595) : const Color(0xff555555),
                               ),

                             ),
                           ),
                                      ),
                                      const SizedBox(height:5,),
                         Padding(
                           padding: const EdgeInsets.only(left:8.0),
                           child: Text(songs[index].title,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                         ),
                         const SizedBox(height: 4,),
                          Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: Text(songs[index].artist,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                          ),

                       ],
                     ))
               ],
             ),
           ),
         );
      },
        separatorBuilder: (context,index) => const SizedBox(width: 14,),
        itemCount: songs.length,
         scrollDirection: Axis.horizontal,
      ),
    );
  }
}
