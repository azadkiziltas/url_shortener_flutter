import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortener/bloc/link_history/link_History_state.dart';
import 'package:url_shortener/bloc/link_history/link_history_event.dart';
import 'package:url_shortener/repository/link_history_repository.dart';

import '../../data/models/link_history_model.dart';

class LinkHistoryBloc extends Bloc<LinkHistoryEvent, LinkHistoryState> {
  final LinkHistoryRepository _linkHistoryRepository;

  LinkHistoryBloc(this._linkHistoryRepository) : super(LinkHistoryEmpty()) {
    on<FetchLinkHistory>(_onFetchLinkHistory);
    on<AddLinkHistory>(_onAddLinkHistory);
    on<DeleteLinkHistory>(_onDeleteLinkHistory);
  }

  void _onFetchLinkHistory(
    FetchLinkHistory event,
    Emitter<LinkHistoryState> emit,
  ) async {
    final linkHistory = await _linkHistoryRepository.getLinkHistory();
    if (linkHistory.isNotEmpty) {
      emit(LinkHistoryLoaded(linkHistory));
    } else {
      emit(LinkHistoryEmpty());
    }
  }

  void _onAddLinkHistory(
      AddLinkHistory event, Emitter<LinkHistoryState> emit) async {
    final List<LinkHistoryModel> currentHistory =
        await _linkHistoryRepository.getLinkHistory();
    int existingIndex =
        currentHistory.indexWhere((link) => link.url == event.link.url);
    if (existingIndex != -1) {
      currentHistory.removeAt(existingIndex);
    }
    currentHistory.insert(0, event.link);
    emit(LinkHistoryLoaded(currentHistory));
    _linkHistoryRepository.saveLinkHistory(currentHistory);
  }

  void _onDeleteLinkHistory(
      DeleteLinkHistory event, Emitter<LinkHistoryState> emit) async {
    final List<LinkHistoryModel> currentHistory =
        await _linkHistoryRepository.getLinkHistory();
    currentHistory.removeWhere((link) => link.url == event.link.url);
    emit(LinkHistoryLoaded(currentHistory));
    _linkHistoryRepository.saveLinkHistory(currentHistory);
  }
}
