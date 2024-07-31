import 'dart:math';

class Images {
  Images();
  List<String> imagePathes = [
    "images/home_background.png",
    "images/home_background2.png",
    "images/home_background3.png",
    "images/home_background4.png",
    "images/home_background5.png",
    "images/home_background6.png",
  ];

  String getImagePath() {
    final random = Random();
    int randomIndex = random.nextInt(imagePathes.length);
    return imagePathes[randomIndex];
  }
}
