import 'package:flutter/material.dart';
import 'package:study_meeting_list/api/notion.dart';
import 'package:study_meeting_list/model/dialog/confirm_dialog.dart';
import 'package:study_meeting_list/router/router.dart';

class TileList extends StatelessWidget {
  final List<String> titleList;
  final List<String> urlList;
  final List<String> dateList;
  const TileList(
      {super.key,
      required this.titleList,
      required this.urlList,
      required this.dateList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 750),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: titleList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: ListTile(
                      tileColor: Colors.white,
                      title: Column(children: [
                        Text(
                          titleList[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          dateList[index],
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        )
                      ]),
                      onTap: () => BaseRouter(urlString: urlList[index]).renderUrl,
                      onLongPress: () => ConfirmDialog(
                              trueFunction: () => Notion(
                                      databaseId:
                                          "153827ef768f4bbc879f43143ea458eb",
                                      context: context)
                                  .savePage(titleList[index], dateList[index]),
                              falseFunction: () {})
                          .showSave(context, "Save to Notion", "ページを保存しますか？")));
            }));
  }
}
