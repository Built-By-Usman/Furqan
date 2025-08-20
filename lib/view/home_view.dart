import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/box_items.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final List<BoxItem> items = [
    BoxItem(
      "Quran",
      Icons.menu_book_rounded, // More elegant than Icons.book
      [Color(0xFF0F2027), Color(0xFF2C5364)], // Dark teal to ocean blue
    ),
    BoxItem(
      "Surah Yaseen",
      Icons.auto_stories_rounded, // Suggests reading a special surah
      [Color(0xFF11998E), Color(0xFF38EF7D)], // Aqua to green
    ),
    BoxItem(
      "Duas",
      Icons.self_improvement_rounded, // Meditative/prayer pose
      [Color(0xFF43C6AC), Color(0xFFF8FFAE)], // Peaceful teal to soft yellow
    ),
    BoxItem(
      "Ask AI",
      Icons.self_improvement_rounded, // Sleek AI bot icon
      [Color(0xFF667EEA), Color(0xFF764BA2)], // Purple-blue gradient
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    gradient: LinearGradient(
                      colors: [Color(0xFF006754), Color(0xFF87D1A4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned(
                  right: -1,
                  bottom: 20,
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset('assets/images/light_quran.png'),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -10,
                  child: Image.asset('assets/images/bismillah.png'),
                ),
              ],
            ),
            SizedBox(height: 50),
            // // Grid
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GridView.builder(
                  itemCount: items.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.95, // tighter height
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return GestureDetector(
                      onTap: (){
                        switch (item.title) {
                          case "Quran":
                            Get.toNamed('/quran_view');
                            break;
                          case "Surah Yaseen":
                            // Navigator.push(contextext, MaterialPageRoute(builder: (_) => SurahYaseenScreen()));
                            break;
                          case "Duas":
                            // Navigator.push(context, MaterialPageRoute(builder: (_) => DuasScreen()));
                            break;
                          case "Ask AI":
                            Get.toNamed('/ai');
                            break;
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: item.gradientColors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: item.gradientColors.last.withOpacity(0.3),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item.icon, size: 40, color: Colors.white),
                            SizedBox(height: 12),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ciaro',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
