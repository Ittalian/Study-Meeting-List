import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:study_meeting_list/model/message.dart';
import 'package:study_meeting_list/router/router.dart';

class Notion {
  final String databaseId;
  final BuildContext context;
  const Notion({required this.databaseId, required this.context});

  String formatDate(String input) {
    final regex = RegExp(r'(\d{4})/(\d{2})/(\d{2}) \(\S+\) (\d{2}:\d{2}) 開催');
    final match = regex.firstMatch(input);

    if (match != null) {
      final year = int.parse(match.group(1)!);
      final month = int.parse(match.group(2)!);
      final day = int.parse(match.group(3)!);
      final time = match.group(4)!;

      final timeParts = time.split(':');
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);

      final dateTime = DateTime(year, month, day, hour, minute);

      final formattedDateTime = dateTime.toIso8601String();
      return '${formattedDateTime.substring(0, 19)}+09:00';
    }

    throw const FormatException('エラーが発生しました');
  }

  void savePage(String title, String date, String pageUrl) async {
    const url = 'https://api.notion.com/v1/pages';
    final headers = {
      'Authorization': 'Bearer ${dotenv.get("access_token")}',
      'Content-Type': 'application/json',
      'Notion-Version': '2021-05-13',
    };

    final body = jsonEncode({
      "parent": {"database_id": databaseId},
      "icon": {"type": "emoji", "emoji": "📖"},
      "properties": {
        "Date": {
          "type": "date",
          "date": {"start": formatDate(date)}
        },
        "Name": {
          "type": "title",
          "title": [
            {
              "type": "text",
              "text": {"content": title}
            }
          ]
        },
        "Category": {
          "select": {"name": "講義"}
        },
        "媒体": {
          "select": {"name": "Tech Play"}
        },
        "URL": {
          "url": pageUrl
        }
      }
    });

    try {
      await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      String successMessage = "ページを保存しました";
      Message(message: successMessage).informAction(context);
      String routeUrl =
          "https://www.notion.so/89fa5a6284d84823925bd14a49ba73be";
      BaseRouter(urlString: routeUrl).renderUrl();
    } catch (e) {
      String errorMessage = "ページを保存できませんでした";
      Message(message: errorMessage).informAction(context);
    }
  }
}
