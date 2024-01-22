import 'package:flutter/material.dart';
import 'package:safecty/model/repository/model/dropdown_type.dart';
import 'package:searchfield/searchfield.dart';

class SearchDrown extends StatelessWidget {
  const SearchDrown({
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
  final Function(SearchFieldListItem<String?>)? onChange;

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
        SearchField(
          onSuggestionTap: onChange,
          suggestions: data
              .map(
                (e) => SearchFieldListItem<String>(
                  e.value,
                  item: e.id,
                  child: Text(
                    e.value,
                  ),
                ),
              )
              .toList(),
          suggestionState: Suggestion.expand,
          textInputAction: TextInputAction.next,
          hint: hinText,
          searchStyle: TextStyle(
            fontSize: 12,
            color: Colors.black.withOpacity(0.8),
          ),
          validator: (state) {
            if (state!.isEmpty) {
              return 'Please Enter a valid State';
            }
            return null;
          },
          searchInputDecoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 19.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          maxSuggestionsInViewPort: 6,
          itemHeight: 50,
        )
      ],
    );
  }
}
