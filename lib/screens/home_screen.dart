import 'package:flutter/material.dart';

import '../widgets/favourites_page_view.dart';
import '../screens/all_families_screen.dart';
import '../themes/colors.dart' as colors;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: null,
              toolbarHeight: 35,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    // gradient: colors.primaryColor
                    ),
              ),
              bottom: const TabBar(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                tabs: [
                  SizedBox(height: 60, child: Tab(text: 'Characters')),
                  SizedBox(height: 60, child: Tab(text: 'Families')),
                ],
              ),
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: colors.primaryColor),
                ),
                const Expanded(
                  child: TabBarView(
                    children: [FavouritesPageView(), AllFamiliesScreen()],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
