
import 'package:flutter/material.dart';
import 'package:ronfltapp/common/helper/is_dark_mode.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget ? title;
  final Widget? action;
  final Color? backgroundColor;
  final bool hideBack;


  const BasicAppBar({super.key, this.title, this.action, this.backgroundColor, required this.hideBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: AppBar(
        backgroundColor: backgroundColor??Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title:title ?? const Text(''),
        actions: [
          action ?? const SizedBox(),
        ],
        leading: hideBack ? null : IconButton(
      onPressed: (){
      Navigator.pop(context);
      },
            icon: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
      color: context.isDarkMode ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.04),
      shape: BoxShape.circle,
      ),
      child: Icon(Icons.arrow_back_ios_new,size: 15, color: context.isDarkMode ? Colors.white : Colors.black,),)
      )
      ),
    );
  }

  @override
  Size get preferredSize =>Size.fromHeight(kToolbarHeight);
}
