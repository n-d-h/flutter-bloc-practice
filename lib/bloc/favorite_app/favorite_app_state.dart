part of 'favorite_app_bloc.dart';

enum ListStatus { loading, success, failure }

class FavoriteAppState extends Equatable {
  final List<FavoriteAppModel> apps;
  final ListStatus status;

  const FavoriteAppState({
    this.apps = const [],
    this.status = ListStatus.loading,
  });

  FavoriteAppState copyWith({
    List<FavoriteAppModel>? apps,
    ListStatus? status,
  }) {
    return FavoriteAppState(
      apps: apps ?? this.apps,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [apps, status];
}
