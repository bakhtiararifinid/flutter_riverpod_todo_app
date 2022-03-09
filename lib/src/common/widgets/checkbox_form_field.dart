import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    Key? key,
    Widget? title,
    void Function(bool?)? onChanged,
    FormFieldSetter<bool>? onSaved,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (state) => _buildCheckbox(state, title, onChanged),
        );

  static Widget _buildCheckbox(
    FormFieldState<bool> state,
    Widget? title,
    void Function(bool?)? onChanged,
  ) {
    return CheckboxListTile(
      dense: state.hasError,
      title: title,
      value: state.value,
      onChanged: (value) {
        if (onChanged != null) onChanged(value);
        state.didChange(value);
      },
      subtitle: state.hasError ? _buildErrorText(state.errorText!) : null,
    );
  }

  static Widget _buildErrorText(String message) {
    return Builder(
      builder: (BuildContext context) => Text(
        message,
        style: TextStyle(color: Theme.of(context).errorColor),
      ),
    );
  }
}
