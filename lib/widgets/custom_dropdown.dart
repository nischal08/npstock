import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final Function(String) onChanged;

  const CustomDropdown(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.hintText});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 2,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        // value: currentValue,
        hint: Text(widget.hintText),
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            widget.onChanged(value);
            setState(() {
              currentValue = value;
            });
          }
        },
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        underline: const SizedBox(),
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
