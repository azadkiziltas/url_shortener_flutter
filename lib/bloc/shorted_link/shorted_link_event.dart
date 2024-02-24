sealed class ShortedLinkEvent {}

final class LoadShortedLinkEvent extends ShortedLinkEvent {
  final String url;

  LoadShortedLinkEvent(this.url);
}
