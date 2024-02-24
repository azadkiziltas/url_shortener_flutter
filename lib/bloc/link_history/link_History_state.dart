import 'package:url_shortener/data/models/shorted_link_model.dart';

import '../../data/models/link_history_model.dart';

abstract class LinkHistoryState {}

class LinkHistoryLoaded extends LinkHistoryState {
  final List<LinkHistoryModel> linkHistory;

  LinkHistoryLoaded(this.linkHistory);
}

class LinkHistoryEmpty extends LinkHistoryState {}

class LinkHistoryError extends LinkHistoryState {
  final String message;

  LinkHistoryError(this.message);
}
