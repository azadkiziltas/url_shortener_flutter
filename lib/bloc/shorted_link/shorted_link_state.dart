import 'package:url_shortener/data/models/shorted_link_model.dart';

sealed class ShortedLinkState {}

final class ShortedLinkInitialState extends ShortedLinkState {}

final class ShortedLinkLoadingState extends ShortedLinkState {}

final class ShortedLinkSuccessState extends ShortedLinkState {
  final ShortedLinkModel shortedLinkModel;

  ShortedLinkSuccessState(this.shortedLinkModel);
}

final class ShortedLinkErrorState extends ShortedLinkState {
  final String error;

  ShortedLinkErrorState(this.error);
}
