import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:safecty/model/repository/model/dropdown_type.dart';

class DropDowInspection extends StatelessWidget {
  const DropDowInspection({
    super.key,
    required this.label,
    required this.hinText,
    required this.data,
    required this.value,
    this.onChange,
  });

  final String label;
  final String hinText;
  final List<DropDownType> data;
  final String? value;
  final FormFieldSetter<String>? onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField2<String>(
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          hint: Text(
            hinText,
            style: const TextStyle(fontSize: 14),
          ),
          items: data
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item.id,
                  child: Text(
                    item.value,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              )
              .toList(),
          validator: (value) {
            if (value == null) {
              return 'Please select gender.';
            }
            return null;
          },
          onChanged: onChange,
          onSaved: (value) {
            value = value.toString();
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ],
    );
  }
}
