import 'package:bloc_learner/common/assets.dart';

class CardModel {
  final String name, image, date;

  CardModel({required this.name, required this.image, required this.date});
}

List<CardModel> demoCardData = [
  CardModel(
    name: "Shenzhen GLOBAL DESIGN AWARD 2018",
    image: Assets.paralax3,
    date: "4.20-30",
  ),
  CardModel(
    name: "Dawan District, Guangdong Hong Kong and Macao",
    image: Assets.paralax2,
    date: "4.28-31",
  ),
  CardModel(
    name: "Shenzhen GLOBAL DESIGN AWARD 2018",
    image: Assets.paralax1,
    date: "4.20-30",
  ),
];