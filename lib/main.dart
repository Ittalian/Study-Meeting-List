import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:study_meeting_list/model/images.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:study_meeting_list/view/tile_list.dart';

Future<ServiceAccountCredentials> loadCredentials() async {
  final credencials = {
    "type": "service_account",
    "project_id": "tech-play-notify",
    "private_key_id": dotenv.get('private_key_id'),
    "private_key":
        dotenv.get('private_key'),
    "client_email":
        "tech-play-notify-account@tech-play-notify.iam.gserviceaccount.com",
    "client_id": dotenv.get('client_id'),
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url":
        "https://www.googleapis.com/robot/v1/metadata/x509/tech-play-notify-account%40tech-play-notify.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  };
  return ServiceAccountCredentials.fromJson(credencials);
}

void main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();

  List<String> titleList = [];
  List<String> urlList = [];
  List<String> dateList = [];

  final credentials = await loadCredentials();
  final scopes = [SheetsApi.spreadsheetsReadonlyScope];
  final client = await clientViaServiceAccount(credentials, scopes);
  final sheetsApi = SheetsApi(client);
  String spreadsheetId = dotenv.get('spreadsheetId');
  const range = 'A2:C50';

  final response =
      await sheetsApi.spreadsheets.values.get(spreadsheetId, range);
  if (response.values != null) {
    for (var row in response.values!) {
      titleList.add(row[0].toString());
      urlList.add(row[1].toString());
      dateList.add(row[2].toString());
    }
  }
  client.close();
  runApp(StudyMeetingList(
      titleList: titleList, urlList: urlList, dateList: dateList));
}

class StudyMeetingList extends StatelessWidget {
  final List<String> titleList;
  final List<String> urlList;
  final List<String> dateList;

  const StudyMeetingList(
      {super.key,
      required this.titleList,
      required this.urlList,
      required this.dateList});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(titleList: titleList, urlList: urlList, dateList: dateList),
    );
  }
}

class Home extends StatefulWidget {
  final List<String> titleList;
  final List<String> urlList;
  final List<String> dateList;
  const Home(
      {super.key,
      required this.titleList,
      required this.urlList,
      required this.dateList});

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
          body: TileList(
              titleList: widget.titleList,
              urlList: widget.urlList,
              dateList: widget.dateList)),
    );
  }
}
