import 'dart:async';

import 'package:pageloader/pageloader.dart';

part 'material_input_po.g.dart';

@PageObject()
abstract class MaterialInputPO {
  MaterialInputPO();

  factory MaterialInputPO.create(PageLoaderElement context) =
      $MaterialInputPO.create;

  String get value => _input.visibleText;

  @ByTagName('input')
  PageLoaderElement get _input;

  Future<void> setValue(String value) async {
    await _input.clear();
    return _input.type(value);
  }
}
