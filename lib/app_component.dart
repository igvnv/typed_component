import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

import 'custom_selector_component.dart';

@Component(
  selector: 'app',
  templateUrl: 'app_component.html',
  styleUrls: ['app_component.css'],
  directives: [coreDirectives, formDirectives, CustomSelectorComponent],
  pipes: [commonPipes],
  directiveTypes: [
    Typed<CustomSelectorComponent<int>>(on: 'intSelector'),
    Typed<CustomSelectorComponent<String>>(on: 'strSelector'),
  ]
)
class AppComponent {
  List<SelectorOption<int>> numericOptions = [
    SelectorOption(1, 'One'),
    SelectorOption(2, 'Two'),
    SelectorOption(3, 'Three'),
  ];

  List<int> selectedNumbers = [];

  List<SelectorOption<String>> stringOptions = [
    SelectorOption('one', 'One'),
    SelectorOption('two', 'Two'),
    SelectorOption('three', 'Three'),
  ];

  List<String> selectedStrings = [];
}