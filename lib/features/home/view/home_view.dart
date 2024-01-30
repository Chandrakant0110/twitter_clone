import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/theme/theme.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    int _page = 0;

    final appBar = UIConstants.appBar();

    void onPageChange(int index) {
      setState(() {
        _page = index;
        print('changed to page $index');
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: const Text('Lets Start with the HomePage'),
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: _page,
          onTap: onPageChange,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _page == 0
                    ? AssetsConstants.homeFilledIcon
                    : AssetsConstants.homeOutlinedIcon,
                color: Pallete.whiteColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AssetsConstants.searchIcon,
                color: Pallete.whiteColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _page == 2
                    ? AssetsConstants.notifFilledIcon
                    : AssetsConstants.notifOutlinedIcon,
                color: Pallete.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
