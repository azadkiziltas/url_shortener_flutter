import 'package:url_shortener/data/models/link_history_model.dart';

abstract class LinkHistoryEvent {}

class FetchLinkHistory extends LinkHistoryEvent {}

class AddLinkHistory extends LinkHistoryEvent {
  final LinkHistoryModel link;

  AddLinkHistory(this.link);
}

class DeleteLinkHistory extends LinkHistoryEvent {
  final LinkHistoryModel link;

  DeleteLinkHistory(this.link);
}
