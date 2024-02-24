import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_shortener/bloc/link_history/link_History_state.dart';
import 'package:url_shortener/bloc/link_history/link_history_bloc.dart';
import 'package:url_shortener/data/models/link_history_model.dart';
import '../../../bloc/link_history/link_history_event.dart';
import '../../../constants/user_theme.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late final LinkHistoryBloc _linkHistoryBloc;

  @override
  void initState() {
    _linkHistoryBloc = BlocProvider.of<LinkHistoryBloc>(context);
    _linkHistoryBloc.add(FetchLinkHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<LinkHistoryBloc, LinkHistoryState>(
            builder: (context, state) {
              if (state is LinkHistoryLoaded) {
                if(state.linkHistory.isNotEmpty){
                  return ListView.builder(
                    itemCount: state.linkHistory.length,
                    itemBuilder: (context, index) {
                      final link = state.linkHistory[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8, right: 8, bottom: 8),
                        child: ListTile(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: link.shortedUrl));
                          },
                          tileColor: UserTheme.onPrimary,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          title: Text(
                            link.shortedUrl,
                            style: TextStyle(
                                color: UserTheme.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(link.url),
                          trailing: IconButton(
                              onPressed: () {
                                BlocProvider.of<LinkHistoryBloc>(context).add(
                                    DeleteLinkHistory(LinkHistoryModel(
                                        url: link.url,
                                        shortedUrl: link.shortedUrl)));
                              },
                              icon: const Icon(Icons.delete_forever)),
                        ),
                      );
                    },
                  );

                }
                else{
                  return ListView.builder(
                    itemCount: state.linkHistory.length,
                    itemBuilder: (context, index) {
                      final link = state.linkHistory[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8, right: 8, bottom: 8),
                        child: ListTile(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: link.shortedUrl));
                          },
                          tileColor: UserTheme.onPrimary,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15))),
                          title: Text(
                            link.shortedUrl,
                            style: TextStyle(
                                color: UserTheme.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(link.url),
                          trailing: IconButton(
                              onPressed: () {
                                BlocProvider.of<LinkHistoryBloc>(context).add(
                                    DeleteLinkHistory(LinkHistoryModel(
                                        url: link.url,
                                        shortedUrl: link.shortedUrl)));
                              },
                              icon: const Icon(Icons.delete_forever)),
                        ),
                      );
                    },
                  );

                }

              } else {
                return const Center(
                  child: Text('Link history is empty.',style: TextStyle(
                    fontSize: 20
                  ),),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
