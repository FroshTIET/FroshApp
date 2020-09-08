import 'package:flutter/material.dart';
import 'package:froshApp/screens/academics.dart';
import 'package:froshApp/screens/home.dart';
import 'package:froshApp/screens/profile.dart';
import 'package:froshApp/state/themeNotifier.dart';
import 'package:froshApp/widgets/keepalvie.dart';
import 'package:froshApp/widgets/timeline.dart';
import 'package:provider/provider.dart';

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: () =>
                Provider.of<ThemeProvider>(context, listen: false).switchTheme,
            child: Text("Change theme"),
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: PageScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        // children: List.generate(4, (index) => Home()),
        children: [
          KeepAlivePage(child: Home()),
          KeepAlivePage(
            child: ShowcaseFroshTimeline(),
          ),
          KeepAlivePage(
            child: DashboardTwoPage(),
          ),
          KeepAlivePage(child: ProfilePage()),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: 7.0),
              barIcon(icon: Icons.home, page: 0, title: "Home"),
              barIcon(icon: Icons.whatshot, page: 1, title: "TimeLine"),
              barIcon(icon: Icons.bubble_chart, page: 2, title: "Study"),
              barIcon(icon: Icons.person, page: 3, title: "Profile"),
              SizedBox(width: 7.0),
            ],
          ),
        ),
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  Widget barIcon(
      {IconData icon = Icons.home,
      int page = 0,
      bool badge = false,
      String title}) {
    // return IconButton(
    //   icon: badge ? IconBadge(icon: icon, size: 24.0) : Icon(icon, size: 24.0),
    //   color:
    //       _page == page ? Theme.of(context).accentColor : Colors.blueGrey[300],
    //   onPressed: () => _pageController.animateToPage(page,
    //       duration: Duration(milliseconds: 500), curve: Curves.ease),
    // );
    var isSelected = _page == page;
    final Duration animationDuration = const Duration(milliseconds: 250);
    const Color selectedColor = Color(0xFF2e78c3);
    const Color backgroundColor = Colors.white;
    const Color unselectedColor = Colors.black;

    return AnimatedContainer(
      width: isSelected ? 120 : 50,
      duration: animationDuration,
      decoration: BoxDecoration(
        color: isSelected ? selectedColor.withOpacity(0.2) : backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
      ),
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconTheme(
                data: IconThemeData(
                    color: isSelected ? selectedColor : unselectedColor),
                child: IconButton(
                  icon: Icon(icon),
                  onPressed: () => _pageController.animateToPage(page,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease),
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                      style: TextStyle(
                          fontSize: 14,
                          color: selectedColor,
                          fontWeight: FontWeight.bold),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(title),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}
