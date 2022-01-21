import 'dart:async';
import 'dart:developer';

import 'package:flutter_shimmer_loading_effect/model/model.dart';

class GetInfoHelper {

  List<Item> l = [
    Item(
        url: "https://i.ytimg.com/vi/28IRaMc1AiU/hqdefault.jpg",
        title: "Funciona correctamente"),
    Item(
        url:
            "https://memes.co.in/memes/update/uploads/2022/01/WhatsApp-Image-2022-01-10-at-2.12.20-AM-4-1014x1024.jpeg",
        title: "Funciona con bugs"),
    Item(
        url: "https://i.imgur.com/KsHHnyuh.jpg",
        title: "No funciona correctamente"),
    Item(
        url: "https://i.ytimg.com/vi/KZB5If5WSuU/hqdefault.jpg",
        title: "No compila"),
    Item(
        url: "https://i.ytimg.com/vi/83A17zE88lk/hqdefault.jpg",
        title: "El cliente pide cambios"),
  ];
  int counter = 1;

  Future<Items> getData() async {
    Items? response;
    await new Future.delayed(new Duration(seconds: 3));
    response = Items(times: counter, items: l);
    counter = counter+1;
    return response;
  }
}
