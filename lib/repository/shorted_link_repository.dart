import 'package:url_shortener/provider/shorted_link_provider.dart';

import '../data/models/shorted_link_model.dart';

abstract class IShortedLinkRepository {
  Future<ShortedLinkModel> getShortedLink(String url);
}

class ShortedLinkRepository implements IShortedLinkRepository {
  final ShortedLinkProvider shortedLinkProvider;

  ShortedLinkRepository(this.shortedLinkProvider);

  @override
  Future<ShortedLinkModel> getShortedLink(String url) {
    return shortedLinkProvider.getShortedLink(url);
  }
}
