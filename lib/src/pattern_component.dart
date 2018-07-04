import 'package:angular/angular.dart';

@Component(
  selector: 'pattern',
  templateUrl: 'pattern_component.html',
  styleUrls: ['pattern_component.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
)
class PatternComponent {
  @Input()
  String pattern;
}
