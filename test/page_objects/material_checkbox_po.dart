import 'dart:async';

import 'package:pageloader/pageloader.dart';

part 'material_checkbox_po.g.dart';

@PageObject()
abstract class MaterialCheckboxPO {
  MaterialCheckboxPO();

  factory MaterialCheckboxPO.create(PageLoaderElement context) =
      $MaterialCheckboxPO.create;

  bool get checked => _icon.visibleText == 'check_box';

  @ByClass('icon')
  PageLoaderElement get _icon;

  @ByClass('icon-container')
  PageLoaderElement get _iconContainer;

  Future<void> setValue(bool value) async {
    if (value != checked) {
      return _iconContainer.click();
    }
  }
}
