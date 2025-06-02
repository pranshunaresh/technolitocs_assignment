import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String prefix;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.prefix = '',
    this.hintText = 'Please enter text',
    this.keyboardType = TextInputType.text,
    this.isPasswordField = false,
    this.inputFormatters,
    this.maxLength,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const gray400 = Color(0xFF8B8B8B);

    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9999),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            if (widget.prefix.isNotEmpty) ...[
              Text(
                widget.prefix,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 10),
              Container(width: 1, height: 25, color: Colors.black26),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: _focusNode,
                obscureText: widget.isPasswordField,
                keyboardType: widget.keyboardType,
                maxLength: widget.maxLength,
                inputFormatters: widget.inputFormatters,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(color: gray400),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
