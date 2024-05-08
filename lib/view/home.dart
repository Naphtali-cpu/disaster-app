import 'package:disastermanagement/base/alerts.dart';
import 'package:disastermanagement/view/pages/post.dart';
import 'package:disastermanagement/view/pages/reports.dart';
import 'package:disastermanagement/widgets/mybutton.dart';
import 'package:disastermanagement/widgets/mytext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

const canvasColor = Color(0xFF2E2E48);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);

  String title = "Reports";
  MyAlerts myAlerts = MyAlerts();
  final _key = GlobalKey<ScaffoldState>();
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Reports"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.star),
        title: ("Post Report"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

    ];
  }

  List<Widget> _buildScreens() {
    return [
      const ReportsView(),
      const PostReport(),
    ];
  }

  _getTitle(int pos) {
    switch (pos) {
      case 0:
        title = "Reports";
      case 1:
        title = "Post Report";
      default:
        title = "Not Available";
    }
    setState(() {});
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.popUntil(context, ModalRoute.withName('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: canvasColor,
          title: MyTextView(
            data: title,
            fontsize: 20,
            colors: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          actions: [
            MyTextView(
              data: 'Logout',
              colors: Colors.white,
              fontsize: 18,
            )
          ],
        ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style1, // Choose the nav bar style with this property.
          onItemSelected: (pos) {
            _getTitle(pos);
          },
        ),
      ),
      );
  }
}
