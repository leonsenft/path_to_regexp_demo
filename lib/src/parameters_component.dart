import 'package:angular/angular.dart';
import 'package:path_to_regexp/path_to_regexp.dart';

@Component(
  selector: 'parameters',
  templateUrl: 'parameters_component.html',
  styleUrls: ['parameters_component.css'],
  directives: [NgFor, NgIf],
)
class ParametersComponent {
  @Input()
  List<ParameterToken> parameters;
}
