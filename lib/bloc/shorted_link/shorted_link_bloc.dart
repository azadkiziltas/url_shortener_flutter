import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortener/bloc/shorted_link/shorted_link_event.dart';
import 'package:url_shortener/bloc/shorted_link/shorted_link_state.dart';

import 'package:url_shortener/repository/shorted_link_repository.dart';

class ShortedLinkBloc extends Bloc<ShortedLinkEvent, ShortedLinkState> {
  final ShortedLinkRepository _shortedLinkRepository;

  ShortedLinkBloc(this._shortedLinkRepository)
      : super(ShortedLinkInitialState()) {
    on<ShortedLinkEvent>((event, emit) async {
      if (event is LoadShortedLinkEvent) {
        emit(ShortedLinkLoadingState());
        try {
          final shortedUrl =
              await _shortedLinkRepository.getShortedLink(event.url);
          emit(ShortedLinkSuccessState(shortedUrl));
        } catch (e) {
          emit(ShortedLinkErrorState(e.toString()));
          print(e.toString());
        }
      }
    });
  }
}
