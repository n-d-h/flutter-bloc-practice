part of 'favorite_app_bloc.dart';

abstract class FavoriteAppEvent extends Equatable {
  const FavoriteAppEvent();

  @override
  List<Object> get props => [];
}

class FetchFavoriteApp extends FavoriteAppEvent {}

class AddFavorite extends FavoriteAppEvent {
  final FavoriteAppModel app;

  const AddFavorite({required this.app});

  @override
  List<Object> get props => [app];
}

class DeletingFavorite extends FavoriteAppEvent {
  final FavoriteAppModel app;

  const DeletingFavorite({required this.app});

  @override
  List<Object> get props => [app];
}

class RemoveFavorite extends FavoriteAppEvent {
  final List<FavoriteAppModel> removeApps;

  const RemoveFavorite({required this.removeApps});

  @override
  List<Object> get props => [removeApps];
}
