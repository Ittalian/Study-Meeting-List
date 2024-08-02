import 'dart:math';

class Images {
  Images();
  List<String> imagePathes = [
    "images/home_background.jpg",
    "images/home_background2.jpg",
    "images/home_background3.jpg",
    "images/home_background4.jpg",
  ];

  String getImagePath() {
    final random = Random();
    int randomIndex = random.nextInt(imagePathes.length);
    return imagePathes[randomIndex];
  }
}
