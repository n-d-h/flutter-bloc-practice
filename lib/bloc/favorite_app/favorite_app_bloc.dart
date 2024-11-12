import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_learner/models/favorite_app_model.dart';
import 'package:bloc_learner/repositories/favorite_repository.dart';
import 'package:equatable/equatable.dart';

part 'favorite_app_event.dart';

part 'favorite_app_state.dart';

class FavoriteAppBloc extends Bloc<FavoriteAppEvent, FavoriteAppState> {
  FavoriteAppBloc() : super(const FavoriteAppState()) {
    on<FetchFavoriteApp>(fetchList);
    on<AddFavorite>(addFavorite);
    on<DeletingFavorite>(deleting);
    on<RemoveFavorite>(removeApps);
    _init();
  }

  void _init() {
    add(FetchFavoriteApp());
  }

  FutureOr<void> fetchList(
      FetchFavoriteApp event, Emitter<FavoriteAppState> emit) async {
    emit(state.copyWith(status: ListStatus.loading));
    try {
      final List<FavoriteAppModel> apps =
          await FavoriteRepository().fetchItems();
      emit(state.copyWith(apps: apps, status: ListStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ListStatus.failure));
    }
  }

  void addFavorite(AddFavorite event, Emitter<FavoriteAppState> emit) {
    // update isFavorite property of the app
    final app = event.app.copyWith(isFavorite: !event.app.isFavorite);
    final updatedApps =
        state.apps.map((e) => e.id == app.id ? app : e).toList();
    // final updatedApps = List<FavoriteAppModel>.from(state.apps)
    //   ..[state.apps.indexWhere((element) => element.id == app.id)] = app;
    emit(state.copyWith(apps: updatedApps));
  }

  void deleting(DeletingFavorite event, Emitter<FavoriteAppState> emit) {
    final app = event.app.copyWith(isDeleting: !event.app.isDeleting);
    final updatedApps =
        state.apps.map((e) => e.id == app.id ? app : e).toList();
    emit(state.copyWith(apps: updatedApps));
  }

  void removeApps(RemoveFavorite event, Emitter<FavoriteAppState> emit) {
    final updatedApps =
        state.apps.where((app) => !event.removeApps.contains(app)).toList();
    // change the isDeleting property from updatedApps to false
    for (var app in updatedApps) {
      app.copyWith(isDeleting: false);
    }
    emit(state.copyWith(apps: updatedApps));
  }
}
