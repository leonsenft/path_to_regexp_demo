import 'package:angular/angular.dart';
import 'package:angular_components/material_checkbox/material_checkbox.dart';
import 'package:angular_components/material_input/material_input.dart';

import 'src/match_component.dart';
import 'src/model.dart';
import 'src/parameters_component.dart';
import 'src/pattern_component.dart';

@Component(
  selector: 'app',
  templateUrl: 'app_component.html',
  styleUrls: ['app_component.css'],
  directives: [
    MatchComponent,
    MaterialCheckboxComponent,
    materialInputDirectives,
    NgFor,
    NgIf,
    ParametersComponent,
    PatternComponent,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class AppComponent {
  final model = Model('', '');

  String get matchClass => model.hasMatch ? 'yes' : 'no';

  void handlePathChange(String value) {
    model.path = value;
  }

  void handleRouteChange(String value) {
    model.route = value;
  }
}
