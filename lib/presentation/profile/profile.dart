import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ronfltapp/common/helper/is_dark_mode.dart';
import 'package:ronfltapp/common/widgets/appbar/app_bar.dart';
import 'package:ronfltapp/presentation/profile/bloc/profile_infor_state.dart';
import 'package:ronfltapp/presentation/song_player/pages/song_player.dart';

import '../../common/widgets/favorite_button/favorite_button.dart';
import '../../core/configs/constants/app_urls.dart';
import 'bloc/favorite_list_cubit.dart';
import 'bloc/favorite_list_state.dart';
import 'bloc/profile_infor_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(hideBack: false,title: Text('Profile'),  backgroundColor: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileInfo(context),
          const SizedBox(height: 30,),
          _favoriteSongs()
        ],
      ),
    );
  }
  Widget profileInfo(BuildContext context){
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..loadProfileInfo(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5 ,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50)
          )),
        child: BlocBuilder<ProfileInfoCubit,ProfileInfoState>(
          builder: (context, state){
            if (state is ProfileInfoLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProfileInfoLoaded){
              return  Column(
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                state.userEntity.imageURL!
                            )
                        )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Text(
                      state.userEntity.email!
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    state.userEntity.fullName!,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                    ),
                  )
                ],
              );
            }
            if(state is ProfileInfoFailure) {
              return const Text(
                  'Please try again'
              );
            }
            return const SizedBox();
          }
        ),
      ),
    );
  }
  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FAVORITE SONGS',
            ),

            const SizedBox(
              height: 20,
            ),
            BlocBuilder<FavoriteSongsCubit,FavoriteSongsState>(
              builder: (context,state) {
                if(state is FavoriteSongsLoading) {
                  return const CircularProgressIndicator();
                }
                if(state is FavoriteSongsLoaded) {
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => SongPlayer(song: state.favoriteSongs[index],)
                                )
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                '${AppUrls.coverFirestorage}${state.favoriteSongs[index].artist} - ${state.favoriteSongs[index].title}.jpg?${AppUrls.mediaAlt}'
                                            )
                                        )
                                    ),
                                  ),

                                  const SizedBox(width: 10, ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.favoriteSongs[index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),
                                      const SizedBox(height: 5, ),
                                      Text(
                                        state.favoriteSongs[index].artist,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11
                                        ),
                                      ),
                                    ],
                                  )

                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                      state.favoriteSongs[index].duration.toString().replaceAll('.', ':')
                                  ),
                                  const SizedBox(width: 20, ),
                                  FavoriteButton(
                                    song: state.favoriteSongs[index],
                                    key: UniqueKey(),
                                   function : (){
                                      context.read<FavoriteSongsCubit>().removeSong(index);
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 20,),
                      itemCount: state.favoriteSongs.length
                  );
                }
                if(state is FavoriteSongsFailure) {
                  return const Text(
                      'Please try again.'
                  );
                }
                return Container();
              } ,
            )
          ],
        ),
      ),
    );
  }
}
