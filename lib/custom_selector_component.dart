import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

/// Объект, содержащий значение и его описание (лейбл).
class SelectorOption<T> {
  final T value;
  final String label;

  SelectorOption(this.value, this.label);
}

/// Компонент выбора нескольких значений из списка.
@Component(
  selector: 'custom-selector',
  templateUrl: 'custom_selector_component.html',
  styleUrls: ['custom_selector_component.css'],
  directives: [coreDirectives, formDirectives]
)
class CustomSelectorComponent<T> implements ControlValueAccessor<List<T>> {
  CustomSelectorComponent(NgControl control) {
    control.valueAccessor = this;
  }

  /// Список пар значение/лейбл, доступных для выбора в селекторе.
  @Input()
  List<SelectorOption<T>> options = [];

  /// Возвращает выбрано ли переданное значение.
  bool isSelected(T value) => _selectedValues.contains(value);

  /// Переключает статус выбрано/невыбрано для переданного значения.
  void toggleValue(T value) {
    if (_selectedValues.contains(value)) {
      _selectedValues.remove(value);
    }
    else {
      _selectedValues.add(value);
    }

    writeValue(_selectedValues);
    print(_selectedValues);
  }

  /// Список выбранныех значений.
  List<T> _selectedValues = [];

  final _onValueChange = StreamController<List>.broadcast();

  @override
  void writeValue(newValue) {
    _onValueChange.add(newValue);
  }

  @override
  void registerOnChange(callback) {
    _onValueChange.stream.listen((value) => callback(value));
  }

  @override
  void registerOnTouched(callback) {
    _onTouched = callback;
  }

  Function _onTouched;

  @HostListener('blur')
  void handleBlur(Event event) {
    _onTouched?.call();
  }

  @override
  void onDisabledChanged(bool isDisabled) {}
}