import 'package:flutter/material.dart';

import '../helper/size_helpers.dart';

class DefaultTextBox extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Function(String)? onChanged;
  final bool obscureText;
  final bool enabled;
  final Widget icon;
  final Color backgroundColor;
  final Color? borderColor;
  final bool showBorder;
  final Color textColor;

  const DefaultTextBox({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.labelText,
    required this.textEditingController,
    required this.textInputType,
    required this.backgroundColor,
    this.onChanged,
    required this.obscureText,
    required this.enabled,
    this.borderColor,
    this.showBorder = false,
    this.textColor = const Color(0xFF3F3F3F),
  }) : super(key: key);

  @override
  _DefaultTextBoxState createState() => _DefaultTextBoxState();
}

class _DefaultTextBoxState extends State<DefaultTextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Container(
        height: displayHeight(context) * 0.075,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(35),
        ),
        child: TextField(
          textCapitalization: TextCapitalization.words,
          controller: widget.textEditingController,
          keyboardType: widget.textInputType,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          onChanged: widget.onChanged ?? (value) {},
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            enabledBorder: widget.showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide(
                      width: 2,
                      color: widget.borderColor ?? widget.backgroundColor,
                    ),
                  )
                : InputBorder.none,
            disabledBorder: widget.showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide(
                      width: 2,
                      color: widget.borderColor ?? widget.backgroundColor,
                    ),
                  )
                : InputBorder.none,
            focusedBorder: widget.showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide(
                      width: 2,
                      color: widget.borderColor ?? widget.backgroundColor,
                    ),
                  )
                : InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontFamily: "Poppins",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: widget.textColor,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: widget.icon,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: displayHeight(context) * 0.02,
            ),
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(4)),
            //   borderSide: BorderSide(width: 1, color: Colors.black54),
            // ),
            // disabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(4)),
            //   borderSide: BorderSide(width: 1, color: Colors.grey),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(4)),
            //   borderSide: BorderSide(width: 1, color: Colors.black12),
            // ),
          ),
        ),
      ),
    );
  }
}
