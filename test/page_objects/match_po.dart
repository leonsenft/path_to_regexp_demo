import 'package:pageloader/pageloader.dart';

part 'match_po.g.dart';

@PageObject()
abstract class MatchPO {
  MatchPO();

  factory MatchPO.create(PageLoaderElement context) = $MatchPO.create;

  Map<String, String> get arguments {
    final result = <String, String>{};
    for (final argument in _arguments) {
      final words = argument.visibleText.split(' ');
      final name = words[0];
      final value = words[1];
      result[name] = value;
    }
    return result;
  }

  bool get hasMatch => _body.visibleText.startsWith('This path matches');

  @ByClass('item')
  List<PageLoaderElement> get _arguments;

  @ByTagName('div')
  PageLoaderElement get _body;
}
