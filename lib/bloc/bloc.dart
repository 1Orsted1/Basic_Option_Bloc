import 'package:bloc/bloc.dart';
import 'package:flutter_shimmer_loading_effect/bloc/event.dart';
import 'package:flutter_shimmer_loading_effect/bloc/state.dart';
import 'package:flutter_shimmer_loading_effect/services/helper.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(ItemsEmpty());

  final _helper = GetInfoHelper();

  // estado =  1
  //event2 -> bloc -> procesar -> estado = 2

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetItemsEvent) {
      yield ItemsLoading();
      try {
        //la respuesta de la api
        final response = await _helper.getData();
        //la pasas al estado
        yield ItemsReceived(response);
      } catch (e) {
        yield ItemsError(error: e.toString());
      }
    }
  }
}
