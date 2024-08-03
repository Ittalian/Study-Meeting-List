import 'package:url_launcher/url_launcher.dart';

class BaseRouter {
  final String urlString;
  const BaseRouter({required this.urlString});

  void renderUrl() {
    final url = Uri.parse(urlString);
    launchUrl(url);
  }
}
