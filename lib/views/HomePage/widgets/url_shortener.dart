import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_shortener/bloc/link_history/link_history_bloc.dart';
import 'package:url_shortener/bloc/link_history/link_history_event.dart';
import 'package:url_shortener/bloc/shorted_link/shorted_link_state.dart';
import 'package:url_shortener/constants/user_theme.dart';
import '../../../bloc/shorted_link/shorted_link_bloc.dart';
import '../../../bloc/shorted_link/shorted_link_event.dart';
import '../../../data/models/link_history_model.dart';

class UrlShortener extends StatefulWidget {
  const UrlShortener({super.key});

  @override
  State<UrlShortener> createState() => _UrlShortenerState();
}

class _UrlShortenerState extends State<UrlShortener> {
  bool isLoadingShortLink = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Card(
      elevation: 0,
      color: UserTheme.primaryColor,
      margin: EdgeInsets.zero,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: SizedBox(
            height: 60,
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(20),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    onPressed: () {
                      textEditingController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),

                filled: true,
                hintText: "Shorten a link here...",
                fillColor: UserTheme.background,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FilledButton(
                      onPressed: () async {
                        Clipboard.getData(Clipboard.kTextPlain).then((value){
                          if(value != null){
                            textEditingController.text = value.text!;
                          }
                        });

                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: UserTheme.secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text("PASTE"),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: FilledButton(
                      onPressed: () {
                        if (!isLoadingShortLink) {
                          String url = textEditingController.text;
                          BlocProvider.of<ShortedLinkBloc>(context)
                              .add(LoadShortedLinkEvent(url));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: UserTheme.secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: BlocBuilder<ShortedLinkBloc, ShortedLinkState>(
                        builder: (context, state) {
                          if (state is ShortedLinkLoadingState) {
                            isLoadingShortLink = true;
                            return CircularProgressIndicator(
                              color: UserTheme.background,
                            );
                          }
                          if (state is ShortedLinkSuccessState) {
                            isLoadingShortLink = false;
                            String url = textEditingController.text;
                            BlocProvider.of<LinkHistoryBloc>(context).add(
                                AddLinkHistory(LinkHistoryModel(
                                    url: url, shortedUrl: state.shortedLinkModel.data)));
                            return  const Text("SHORTEN IT");
                          }
                          if (state is ShortedLinkErrorState) {
                            if(state.error == "400"){
                            Fluttertoast.showToast(msg: "Please enter a valid link.");
                            }
                            else{
                              Fluttertoast.showToast(msg: "Please check your connection.");
                            }
                            isLoadingShortLink = false;
                            return const Text("SHORTEN IT");
                          }
                          return const Text("SHORTEN IT");
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
