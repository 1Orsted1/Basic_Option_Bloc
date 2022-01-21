import 'package:equatable/equatable.dart';
import 'package:flutter_shimmer_loading_effect/model/model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

//estado inicial
class ItemsEmpty extends HomeState {}

class ItemsLoading extends HomeState {}



class ItemsReceived extends HomeState {
  final Items itemsReceived;

  const ItemsReceived(this.itemsReceived);

  @override
  String toString() =>
      "Items{No_Reloads: ${itemsReceived.times}, data: ${itemsReceived.items} }";
}

class ItemsError extends HomeState {
  final String error;

  const ItemsError({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => "Catalog { error: $error }";
}
