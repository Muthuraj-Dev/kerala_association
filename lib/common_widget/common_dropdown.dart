import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../core/res/colors.dart';

// class CommonDropdown<T> extends StatelessWidget {
//   final List<T> items;
//   final T? selectedItem;
//   final String? labelText;
//   final String? hintText;
//   final ValueChanged<T?>? onChanged;
//   final FormFieldValidator<T>? validator;
//   final bool isRequired;
//   final bool isSearchable;
//
//   const CommonDropdown({
//     super.key,
//     required this.items,
//     this.selectedItem,
//     this.labelText,
//     this.hintText,
//     this.onChanged,
//     this.validator,
//     this.isRequired = false,
//     this.isSearchable = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownSearch<T>(
//       key: key,
//       selectedItem: selectedItem,
//       items: (filter, infiniteScrollProps) => items,
//       popupProps:
//           isSearchable
//               ? PopupProps.menu(
//                 showSearchBox: true,
//                 searchFieldProps: TextFieldProps(
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 18,
//                       horizontal: 12,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12.0),
//                       borderSide: const BorderSide(
//                         color: AppColor.divider,
//                         width: 1.5,
//                       ),
//                     ),
//                     hintText: 'Search...',
//                   ),
//                 ),
//               )
//               : PopupProps.menu(),
//
//       decoratorProps: DropDownDecoratorProps(
//         decoration: InputDecoration(
//           fillColor: AppColor.background,
//           filled: true,
//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 18,
//             horizontal: 12,
//           ),
//           suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.0),
//             borderSide: const BorderSide(color: AppColor.textDisable, width: 1.5),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.0),
//             borderSide: const BorderSide(color: AppColor.textDisable, width: 1.5),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12.0),
//             borderSide: const BorderSide(color: AppColor.textDisable, width: 1.5),
//           ),
//           labelText: isRequired ? '${labelText ?? ''} *' : labelText,
//           hintText: hintText,
//           hintStyle:  const TextStyle(color: Colors.black87, fontSize: 18),
//           labelStyle: const TextStyle(color: Colors.black45, fontSize: 18),
//         ),
//       ),
//
//       onChanged: onChanged,
//       validator: validator,
//     );
//   }
// }


class CommonDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String? hintText;
  final String? labelText;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final bool isRequired;
  final bool isSearchable;
  final String Function(T)? itemAsString;
  final bool Function(T, T)? compareFn;
  final int maxVisibleItems;

  const CommonDropdown({
    super.key,
    required this.items,
    this.selectedItem,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.validator,
    this.isRequired = false,
    this.isSearchable = false,
    this.itemAsString,
    this.compareFn,
    this.maxVisibleItems = 5,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      key: key,
      selectedItem: selectedItem,
      items: (filter, _) => items,
      itemAsString: itemAsString,
      compareFn: compareFn,

      popupProps: isSearchable
          ? PopupProps.menu(
        showSearchBox: true,
        constraints: BoxConstraints(
          maxHeight: maxVisibleItems * 48.0,
        ),
        fit: FlexFit.loose,
        // menuProps: MenuProps(
        //   borderRadius: BorderRadius.circular(12),
        //   elevation: 6,
        //   backgroundColor: Colors.white,
        // ),
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: AppColor.divider,
                width: 1.5,
              ),
            ),
            hintText: 'Search...',
          ),
        ),
      )
          : PopupProps.menu(
        constraints: BoxConstraints(
          maxHeight: maxVisibleItems * 48.0,
        ),
        fit: FlexFit.loose,
        menuProps: MenuProps(
          borderRadius: BorderRadius.circular(12),
          elevation: 6,
          backgroundColor: Colors.white,
        ),
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          fillColor: AppColor.background,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          labelText: isRequired ? '${labelText ?? ''} *' : labelText,
          hintText: hintText,
          labelStyle: const TextStyle(color: Colors.black54, fontSize: 18),
          hintStyle: const TextStyle(color: Colors.black38, fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColor.textDisable, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColor.textDisable, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColor.textDisable, width: 1.5),
          ),
        ),
      ),
      onChanged: onChanged,
      validator: validator,

    );
  }
}