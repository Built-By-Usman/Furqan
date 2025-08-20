import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:furqan/model/verse_model.dart';

class QuranService {
  Future<List<Verse>> loadQuran() async {
    final ar = json.decode(
      await rootBundle.loadString('assets/json/quran.json'),
    );
    final ur = json.decode(await rootBundle.loadString('assets/json/ur.json'));

    List<Verse> allVerses = [];

    ar.forEach((surah, verses) {
      for (int i = 0; i < verses.length; i++) {
        final arabicVerse = verses[i];
        final urduVerse = ur[surah][i];
        allVerses.add(
          Verse(
            chapter: arabicVerse['chapter'],
            verse: arabicVerse['verse'],
            arabic: arabicVerse['text'],
            translation: urduVerse['text'],
          ),
        );
      }
    });
    return allVerses;
  }
}
