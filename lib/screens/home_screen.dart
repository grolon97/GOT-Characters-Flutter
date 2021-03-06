import 'package:flutter/material.dart';
import 'package:got_app/widgets/favourites_page_view.dart';
import 'package:got_app/themes/colors.dart' as colors;

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
                  gradient: colors.primaryGradient
                ),
              ),
              bottom: const TabBar(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                tabs: [
                  SizedBox(height: 60, child: Tab(text: 'Characters')),
                  SizedBox(height: 60, child: Tab(text: 'Houses')),
                ],
              ),
            ),
            body: Column(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      gradient: colors.primaryGradient,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Container(
                          height: 25,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 0),
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          decoration: const BoxDecoration(
                            color: colors.lightColor,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, -15),
                                  blurRadius: 20,
                                  spreadRadius: -10,
                                  blurStyle: BlurStyle.normal)
                            ],
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(50)),
                          ),
                        ),
                      ],
                    )),
                const Expanded(
                  child: TabBarView(
                    children: [FavouritesPageView(), Icon(Icons.house_rounded)],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
