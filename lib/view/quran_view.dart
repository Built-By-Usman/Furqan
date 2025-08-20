import 'package:flutter/material.dart';
import 'package:furqan/controllers/quran_controller.dart';
import 'package:furqan/view/surah_view.dart';
import 'package:get/get.dart';

class QuranView extends StatelessWidget {
  QuranView({super.key});

  final QuranController quranController = Get.put(QuranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Furqan',
          style: TextStyle(
            fontFamily: 'ciaro',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(icon: Icon(Icons.search,size: 25,color: Colors.black,), onPressed: () {}),
        )],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF006754), Color(0xFF87D1A4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(40)
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 40,
                child: Text(
                  'القرآن الكريم',
                  style: TextStyle(fontSize: 35, color: Colors.white),
                ),
              ),
              Positioned(
                right: -1,
                bottom: -40,
                child: Image.asset('assets/images/small_quran.png'),
              ),
            ],
          ),
          Obx(() {
            if (quranController.allVerses.isEmpty) {
              return Center(child: CircularProgressIndicator(color: Color(0xFF006754),));
            }

            final surahList = quranController.getSurahNumbers();
            return Expanded(
              child: ListView.builder(
                itemCount: surahList.length,
                itemBuilder: (context, index) {
                  final surah = surahList[index];
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Color(0xFFE6F4F1),
                        // Soft greenish background
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          leading: Image.asset(
                            'assets/images/star.png',
                            height: 40,
                            width: 40,
                          ),
                          title: Text(
                            'سورة ${quranController.surahNames[surah]}',
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFF004B40),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Text(
                            'سورہ نمبر $surah',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF00775C),
                            ),
                          ),
                          onTap: () =>
                              Get.to(() => SurahView(surahNo: surah)),
                          trailing: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFF004B40),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
