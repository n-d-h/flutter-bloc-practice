import 'package:equatable/equatable.dart';

class FavoriteAppModel extends Equatable {
  final int id;
  final String name;
  final bool isDeleting;
  final bool isFavorite;

  const FavoriteAppModel({
    required this.id,
    required this.name,
    this.isDeleting = false,
    this.isFavorite = false,
  });

  FavoriteAppModel copyWith({
    int? id,
    String? name,
    bool? isDeleting,
    bool? isFavorite,
  }) {
    return FavoriteAppModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isDeleting: isDeleting ?? this.isDeleting,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object> get props => [id, name, isDeleting, isFavorite];
}
