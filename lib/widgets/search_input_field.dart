import 'package:flutter/material.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({
    Key? key,
    required this.enabled,
    this.controller,
    this.focusNode,
    this.onTap,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  }) : super(key: key);

  final bool enabled;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final Function()? onTap;
  final Function(String)? onChanged;
  final IconData? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).textTheme.titleSmall!.color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          onChanged: onChanged,
          focusNode: focusNode,
          controller: controller,
          enabled: enabled,
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge!.color,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.titleLarge!.color,
            ),
            prefixIcon: Icon(
              prefixIcon ?? Icons.search,
              color: Theme.of(context).textTheme.titleLarge!.color,
            ),
            suffixIcon: suffixIcon,
            isDense: true,
          ),
        ),
      ),
    );
  }
}
