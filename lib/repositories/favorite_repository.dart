import 'package:bloc_learner/models/favorite_app_model.dart';

class FavoriteRepository {
  Future<List<FavoriteAppModel>> fetchItems() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    return List.generate(100, (index) {
      return FavoriteAppModel(
        id: index,
        name: 'Favorite App $index',
      );
    });
  }
}
