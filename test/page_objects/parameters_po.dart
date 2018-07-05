import 'package:pageloader/pageloader.dart';

part 'parameters_po.g.dart';

class Parameter {
  String name;
  bool optional;

  Parameter(this.name, {this.optional: false});

  @override
  int get hashCode => name.hashCode ^ optional.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Parameter &&
        other.name == name &&
        other.optional == optional;
  }
}

@PageObject()
abstract class ParametersPO {
  ParametersPO();

  factory ParametersPO.create(PageLoaderElement context) = $ParametersPO.create;

  List<Parameter> get parameters {
    final result = <Parameter>[];
    for (final parameter in _parameters) {
      final words = parameter.visibleText.split(' ');
      final name = words[0];
      final optional = words.length > 1 && words[1] == 'OPTIONAL';
      result.add(Parameter(name, optional: optional));
    }
    return result;
  }

  @ByClass('item')
  List<PageLoaderElement> get _parameters;
}
