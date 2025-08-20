import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/ai_message.dart';

class AiController extends GetxController {
  final TextEditingController controller = TextEditingController();
  final RxBool _isLoading = false.obs;
  final RxList<AiMessage> messages = <AiMessage>[].obs;

  bool get isLoading => _isLoading.value;

  final String apiKey = 'AIzaSyCwr1btdznuwFk6Az3ijXTGveqgrUgmUdI';

  Future<void> getResponse() async {
    final prompt = controller.text.trim();
    if (prompt.isEmpty) return;

    messages.add(AiMessage(text: prompt, isUser: true));
    controller.clear();

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey',
    );

    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      "contents": [
        {
          "role": "user",
          "parts": [
            {
              "text": '''
Act as a highly knowledgeable and qualified Islamic scholar (Mufti). Answer each question only based on:

📜 Qur'an (mention complete reference like Surah name and verse number),
📘 Authentic Hadith (must include book name e.g. Sahih Bukhari, Sahih Muslim, etc. and **exact Hadith number**),
🕌 Sunnah (verified actions of Prophet Muhammad ﷺ).

⚠️ Do not generalize or skip details. Your answer MUST:
- Contain clear step-by-step guidance (e.g., how to perform Salah) when asked.
- Include **exact Hadith number** with source (e.g., Sahih Muslim: 397).
- Avoid using phrases like “It’s too long to explain” — answer in full unless user asks for summary.
- Match the language of the question (e.g., reply in Urdu if question is in Urdu).
- Do not use unauthentic sources.
- If a Hadith is weak, say “This Hadith is Da’if” and give its source.
- If there is scholarly disagreement, mention both opinions briefly and include their references.

🎯 Keep your answer respectful, short, structured, and evidence-based.

User’s question:
"$prompt"
'''
            }
          ]
        }
      ]
    });


    try {
      _isLoading.value = true;
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final text = data['candidates'][0]['content']['parts'][0]['text'];
        messages.add(AiMessage(text: text, isUser: false));
      } else {
        messages.add(AiMessage(text: '❌ Error: ${response.statusCode}\n${response.body}', isUser: false));
      }
    } catch (e) {
      messages.add(AiMessage(text: '❌ Exception occurred:\n$e', isUser: false));
    } finally {
      _isLoading.value = false;
    }
  }
}
