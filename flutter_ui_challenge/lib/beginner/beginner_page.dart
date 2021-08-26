import 'package:flutter/material.dart';
import 'package:flutter_ui_challenge/beginner/data/menu.dart';
import 'package:flutter_ui_challenge/beginner/widgets/menu_tile.dart';

class BeginnerLevelPage extends StatefulWidget {
  const BeginnerLevelPage({Key? key}) : super(key: key);

  @override
  _BeginnerLevelPageState createState() => _BeginnerLevelPageState();
}

class _BeginnerLevelPageState extends State<BeginnerLevelPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF741BDC),
            expandedHeight: 320,
            centerTitle: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [StretchMode.zoomBackground],
              background: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      colors: const [
                        Color(0xFFA226CE),
                        Color(0xFF691ADD),
                      ],
                      begin: const FractionalOffset(0.0, 1.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    )),
                  ),
                  ...List.generate(4, (index) => 100 * index)
                      .map((radius) => Positioned(
                          top: -radius.toDouble(),
                          left: -radius.toDouble(),
                          child: Container(
                            width: radius * 2,
                            height: radius * 2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  radius.toDouble(),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(.05),
                                    blurRadius: 1.0,
                                  )
                                ]),
                          ))),
                  SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.notifications_none,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Profile",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                "assets/emma.jpg",
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Emma Watson",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "New York",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildInfoRow("Followers", "5.7m"),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white,
                              ),
                              _buildInfoRow("Following", "824"),
                              Container(
                                width: 1,
                                height: 40,
                                color: Colors.white,
                              ),
                              _buildInfoRow("Total Like", "1.7K"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              height: 120,
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.all(12),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    color: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: 160,
                      alignment: Alignment.center,
                      child: Text(
                        mockMenuData[index].label,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: mockMenuData.length,
              ),
            ),
            ...mockMenuData.map((menu) => MenuTile(menu: menu)).toList()
          ]))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        enableFeedback: false,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme: IconThemeData(
          color: Colors.grey,
        ),
        selectedIconTheme: IconThemeData(
          color: const Color(0xFF741BDC),
        ),
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              label: "Home", icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(
              label: "Bookmark", icon: Icon(Icons.turned_in_not)),
          BottomNavigationBarItem(label: "Likes", icon: Icon(Icons.thumb_up)),
          BottomNavigationBarItem(label: "Settings", icon: Icon(Icons.person)),
        ],
      ),
    );
  }

  Padding _buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
