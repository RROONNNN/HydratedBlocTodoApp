

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ronfltapp/common/helper/is_dark_mode.dart';
import 'package:ronfltapp/common/widgets/appbar/app_bar.dart';
import 'package:ronfltapp/core/configs/assets/app_images.dart';
import 'package:ronfltapp/core/configs/assets/app_vectors.dart';
import 'package:ronfltapp/presentation/root/widgets/news_song.dart';
import 'package:ronfltapp/presentation/root/widgets/play_list.dart';

import '../../core/configs/theme/app_colors.dart';
import '../profile/profile.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with SingleTickerProviderStateMixin {
late TabController _tabController;
@override
  void initState() {
   _tabController=TabController(length: 4, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: BasicAppBar(hideBack: true,title: SvgPicture.asset(AppVectors.logo,height: 40,width: 40,),action: IconButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => const ProfilePage())
            );
          },
          icon: Icon(Icons.person)),),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabs(),
        SizedBox(
          height: 220,
          child: TabBarView(
            controller: _tabController,
            children: [
            NewsSongs(),
            Container(),
            Container(),
            Container(),
          ],

          ),
        ),

            PlayList(),
              ],
            )
      ),
    );
  }

Widget _homeTopCard(){
  return Center(
    child: SizedBox(
      height: 140,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
                AppVectors.homeTopCard
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 60
              ),
              child: Image.asset(
                  AppImages.homeArtist
              ),
            ),
          )
        ],
      ),
    ),
  );
}

  Widget _homeArtistCard(){
return Container(
  height: 150,
  child: Stack(
    children: [
      Align(child: SvgPicture.asset(AppVectors.homeTopCard),
        alignment: Alignment.bottomCenter,
      ),
      Align(child: Padding(
        padding: const EdgeInsets.only(right: 50),
        child: Image.asset(AppImages.homeArtist),
      ),
        alignment: Alignment.bottomRight,)
    ],
  ),
);
  }

  Widget _tabs(){
    return TabBar(
        controller: _tabController,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        indicatorColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 0
        ),
      tabs: const [
        Text(
          'News',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14
          ),
        ),
        Text(
          'Videos',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14
          ),
        ),
        Text(
          'Artists',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14
          ),
        ),
        Text(
          'Podcasts',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14
          ),
        )
      ],);
  }
}

