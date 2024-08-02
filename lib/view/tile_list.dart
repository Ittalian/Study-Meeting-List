import 'package:flutter/material.dart';

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
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: titleList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text(
                      titleList[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onTap: () {},
                  ));
            }));
  }
}
