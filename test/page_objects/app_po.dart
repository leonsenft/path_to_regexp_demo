import 'package:pageloader/pageloader.dart';

import 'match_po.dart';
import 'material_checkbox_po.dart';
import 'material_input_po.dart';
import 'parameters_po.dart';
import 'pattern_po.dart';

part 'app_po.g.dart';

@PageObject()
abstract class AppPO {
  AppPO();

  factory AppPO.create(PageLoaderElement context) = $AppPO.create;

  @ByTagName('match')
  MatchPO get matchPO;

  @ByTagName('parameters')
  ParametersPO get parametersPO;

  MaterialInputPO get pathInputPO => _materialInputsPO[1];

  @ByTagName('pattern')
  PatternPO get patternPO;

  @ByTagName('material-checkbox')
  @WithVisibleText('Case sensitive')
  MaterialCheckboxPO get caseSensitiveCheckboxPO;

  @ByTagName('material-checkbox')
  @WithVisibleText('Prefix')
  MaterialCheckboxPO get prefixCheckboxPO;

  MaterialInputPO get routeInputPO => _materialInputsPO[0];

  @ByTagName('material-input')
  List<MaterialInputPO> get _materialInputsPO;
}
