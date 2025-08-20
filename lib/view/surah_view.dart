import 'package:flutter/material.dart';
import 'package:furqan/controllers/quran_controller.dart';
import 'package:get/get.dart';

class SurahView extends StatelessWidget {
  final int surahNo;

  SurahView({super.key, required this.surahNo});

  final QuranController quranController = Get.put(QuranController());

  @override
  Widget build(BuildContext context) {
    final verses = quranController.getSurah(surahNo);
    final surahName = quranController.surahNames[surahNo] ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF006754),
        title: Text(
          'سورة $surahName',
          style: const TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: const Color(0xFFF3FDFB),
        child: ListView.separated(
          itemCount: verses.length,
          separatorBuilder: (_, __) => const Divider(color: Colors.teal, height: 20),
          itemBuilder: (context, index) {
            final verse = verses[index];
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    verse.arabic,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF004B40),
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 8),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      verse.translation,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF333333),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
