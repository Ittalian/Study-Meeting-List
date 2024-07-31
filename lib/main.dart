import 'package:flutter/material.dart';
import 'package:study_meeting_list/model/images.dart';

void main() {
  runApp(const StudyMeetingList());
}

class StudyMeetingList extends StatelessWidget {
  const StudyMeetingList({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String imagePath = Images().getImagePath();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
