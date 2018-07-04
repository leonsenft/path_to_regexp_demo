import 'package:angular/angular.dart';

import 'model.dart';

@Component(
  selector: 'match',
  templateUrl: 'match_component.html',
  styleUrls: ['match_component.css'],
  directives: [NgFor, NgIf],
)
class MatchComponent {
  @Input()
  Model model;
}
