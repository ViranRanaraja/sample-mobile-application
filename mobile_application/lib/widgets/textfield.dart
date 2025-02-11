// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  bool isPassword;
  final IconData? icon;
  final String type;
  final String? Function(String?)? validator;

  TextFieldWidget({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.isPassword,
    this.icon,
    required this.type,
    required this.validator,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      padding: EdgeInsets.fromLTRB(5.w, 0, 2.w, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          15.dp,
        ),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Column(
        children: [
          TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword,
            validator: widget.validator,
            decoration: InputDecoration(
              suffixIcon: widget.type == "password"
                  ? IconButton(
                      icon: Icon(
                        widget.isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.isPassword = !widget.isPassword;
                        });
                      },
                    )
                  : null,
              hintText: widget.hintText,
              labelText: widget.labelText,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
