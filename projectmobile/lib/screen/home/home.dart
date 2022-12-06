import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:projectmobile/screen/home/components/card_info_home.dart';
import 'package:projectmobile/screen/home/components/rekomendasi_card.dart';
import 'package:projectmobile/screen/home/components/whats_new_card.dart';
import 'package:projectmobile/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List cards = [
    CardInfoHome(),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget headerContent(String icon, String text) {
      return Container(
        margin: EdgeInsets.only(top: 15, right: 10),
        padding: EdgeInsets.fromLTRB(8, 5, 2, 5),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 10,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: boldText13.copyWith(color: primaryColor),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: primaryColor,
            )
          ],
        ),
      );
    }

    //pojok atas home
    Widget header() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Home, Welcome',
                  style: boldText15.copyWith(color: blackColor),
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  'Lusy D',
                  style: boldText15.copyWith(color: blackColor),
                ),
                SizedBox(
                  width: 7,
                ),
                // Image.asset('assets/icons/icon-add.png', width: 14),
              ],
            ),
          ],
        ),
      );
    }

    // Widget indicator(int index) {
    //   return Container(
    //     width: currentIndex == index ? 18 : 5,
    //     height: 5,
    //     margin: EdgeInsets.symmetric(horizontal: 2),
    //     decoration: BoxDecoration(
    //         color: currentIndex == index
    //             ? birutuaColor
    //             : whiteColor.withOpacity(0.7),
    //         borderRadius: BorderRadius.circular(4)),
    //   );
    // }

    Widget cardInfo() {
      int index = -1;
      return Column(
        children: [
          CarouselSlider(
            items: cards
                .map<Widget>((card) => Container(
                      child: card,
                    ))
                .toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              height: 250,
              enableInfiniteScroll: false,
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: cards.map((e) {
          //     index += 1;
          //     return indicator(index);
          //   }).toList(),
          // )
        ],
      );
    }

    //rekomendasi untukmu
    Widget recomendedForYou() {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 16, top: 45, right: 16),
            child: Row(
              children: [
                Text(
                  'Rekomendasi Untukmu',
                  style: nunitoExtraBoldText18.copyWith(
                    color: primaryColor,)
                ),
                Spacer(),
                Text(
                  'See all',
                  style: regulerText12.copyWith(
                    color: primaryColor,
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                RekomendasiCard(
                  title: 'Paket Lite',
                  time: '29 Jun 2021 13:08:07',
                  price: 'Rp 100,000',
                ),
                SizedBox(
                  width: 16,
                ),
                RekomendasiCard(
                  title: 'Internet Dedicated',
                  time: '29 Jun 2021 13:05:07',
                  price: 'Rp 150,000',
                ),
              ],
            ),
          )
        ],  
      );
    }

    Widget whatsNew() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 14),
            child: Text(
              'What’s new ?',
              style: nunitoExtraBoldText18,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                WhatsNewCard(
                  image: 'assets/images/video-subscription.png',
                  text: 'Package',
                  title: 'Video Digital Subscription',
                ),
                SizedBox(
                  width: 16,
                ),
                WhatsNewCard(
                  image: 'assets/images/poin-image.png',
                  text: 'Poin',
                  title: 'Undi-undi Hepi',
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget content() { //kotak bawah
      return Container(
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Navy2Color,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            recomendedForYou(),
            whatsNew(),
          ],
        ),
      );
    }

    //background home
    return Scaffold( 
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.topRight,
            stops: [0.1, 0.8, 1],
            colors: [primaryColor, primaryColor, primaryColor],
          ),
        ),
        child: ScrollConfiguration(
          behavior: MyBehaviour(),
          child: ListView(
            children: [
              header(),
              cardInfo(),
              content(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}