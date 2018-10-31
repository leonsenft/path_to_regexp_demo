import 'package:pageloader/pageloader.dart';

part 'parameters_po.g.dart';

@PageObject()
abstract class ParametersPO {
  ParametersPO();

  factory ParametersPO.create(PageLoaderElement context) = $ParametersPO.create;

  Iterable<String> get parameters => _parameters.map((p) => p.visibleText);

  @ByClass('item')
  List<PageLoaderElement> get _parameters;
}
