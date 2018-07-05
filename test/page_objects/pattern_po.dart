import 'package:pageloader/pageloader.dart';

part 'pattern_po.g.dart';

@PageObject()
abstract class PatternPO {
  PatternPO();

  factory PatternPO.create(PageLoaderElement context) = $PatternPO.create;

  String get pattern => _pre.visibleText;

  @ByTagName('pre')
  PageLoaderElement get _pre;
}
