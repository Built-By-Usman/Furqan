import 'package:furqan/view/ai_view.dart';
import 'package:furqan/view/home_view.dart';
import 'package:furqan/view/quran_view.dart';
import 'package:furqan/view/surah_view.dart';
import 'package:get/get.dart';

final allPages = [
  GetPage(name: '/', page: ()=>HomeView()),
  GetPage(name: '/quran_view', page: () => QuranView()),
  GetPage(
    name: '/surah_view',
    page: () {
      final int surahNo = Get.arguments as int;
      return SurahView(surahNo: surahNo);
    },
  ),
  GetPage(name: '/ai', page: ()=>AiView()),
];
