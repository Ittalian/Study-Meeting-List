import 'package:flutter/material.dart';
import 'package:study_meeting_list/model/images.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:study_meeting_list/view/tile_list.dart';

Future<ServiceAccountCredentials> loadCredentials() async {
  const credencials = {
    "type": "service_account",
    "project_id": "tech-play-notify",
    "private_key_id": "01a7575a5c961b452ef6f3e05377b6c1aebaef3a",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDZfvKHlUL3NP7c\nw3wlxgANSt/EJDPJm1WNUptYVbfkiBBHygBGslRIDhkzDl1uvumvlU73smP+AP7Y\nJE0gHhHlZcRf6VoNxMEWT6KVWvn9jMwInjAysuuOsGLoYSnqfWRS6PYv+OAdNWRg\niM3UfP8KxcH7io6uZVoKiadaAL7AXCFejYdLYVyjA8QZoX1COZmF/EC3XYIyj3NU\nteKMeVWnVFpcw7RVi7mxedGB2+NHqocRdF0+UCNDJhOqByBsL14yne5i/R0rlwJ+\nrc1LjZ9pWcHz7E1YjMWJE2jQj6N7HdZEH3YDylM6GMVmtLK0DTlMwNUAL1ZQ57ku\nfWJw07EHAgMBAAECggEAYqpy1qwRSXkKp1atQquMiXsugNnVfn+Ps4FGhK+6MRvC\nmvaZ4nhywI9Ywi8hlqRX+bXXsYmFUAzej2oEbO4HO1RL3iDLoBRibb8pp+yyHOJb\nCwvMHKvLLZt5+yZc8An7UZtqV3/lF4sJortc+KjNwHLPGdAVAytqSf6BY1SUNEmh\nJB/CCyCbhbgpCi6ilzlqBlxCcSLIknnTxSFH6QbCWEVEi1/pnnSZHEiazuHs5df+\nLGQ9VwOaSFDijPB4Ikee2T9189mBoFS0zX1h+4edj2O2x1PGfFwySPWR/Y0B0bsg\nkIFTTj1Ycqi49S/pr6wIdw/xBttKtMmQfKA5D4vqpQKBgQDu9nRYQZld/jQ+bujx\nno9o7fILBUA39bU/o793CkiALGt1lG8E0f/H3/q0GrRUKAt56NqQYl1Kx+J8Ct3T\nyYuFuotFbGfqGo6N3MgrQG1g3m96dS0lVdZU+0OtOh9kVtmT6uMKpqf95mtFaFCt\nqrvERKCFWLNO66i++Rclamo3ewKBgQDpAK47t+sLD9gdBccCUlUgg/Cp3iOPoznF\nEfUL1AnFy6WZNJAtSF0RRRfYmoqE70yPle1W0CcITlLLq6e/JHK/EHiDm32fphBd\nBS02vxe+qlDjFwAZhZ6NaDJpYntKfQ5iRYS7ypZpj9s53Ea6Km7ZOqrdbBxuuRlN\nosmn32sw5QKBgQCDxzuf1AUstVvANk+VtzgkyFtbQnkIoyJhxv52OiCDNnvIKqQS\nh3BDnDvYCIX7ht3VS9kEGIqUC6jVePSdr56Wj6nwDfk8O4rzppZoa64l5mSZpnbQ\nCQcadDn9FHltTwvLq5OrMv6fYOs1KnKbYvULJkFTZ/fyBLlZH2ppQsbycwKBgHmr\nP1Az0+qs1V8iWy8dKxKVkyBAvTUOOOZtYBZTHN9KXijIR9k9hku0VqVm3ZpZExOP\naKYCf79Ylud/tVKch8a5pRSkJ08sejL4twl1c8K+UQqkQgsRuR+CH4DkShk1gENU\npeEiArUQx5tJKS2hZszMU9jX0WkIAuyFauPcSK75AoGBAIgh5W4TVeqUZu9GiTXf\nrAumE3/k+TAVLkDsal5szD1VTZRrUBAE+T+aCHTf7ajfN5eNVH7qbApcrPrhD2hY\nzFLXftingt3KT0/jXwsE2G9UP5CsypguZUKA4V+7xNF9b+SiSvR2fI2stjuoHkZk\nf3UCaa7y+ftUP+dv36tWKZqS\n-----END PRIVATE KEY-----\n",
    "client_email":
        "tech-play-notify-account@tech-play-notify.iam.gserviceaccount.com",
    "client_id": "112847493833924888711",
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
  WidgetsFlutterBinding.ensureInitialized();

  List<String> titleList = [];
  List<String> urlList = [];
  List<String> dateList = [];

  final credentials = await loadCredentials();
  final scopes = [SheetsApi.spreadsheetsReadonlyScope];
  final client = await clientViaServiceAccount(credentials, scopes);
  final sheetsApi = SheetsApi(client);
  const spreadsheetId = '1IaYKTvuPH-G9ummJGr2ZZU-xYKlJovCzsGBdr2qDQTU';
  const range = 'A2:C100';

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
