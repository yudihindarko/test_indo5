import 'package:flutter/material.dart';

enum TextFieldIntroType {
  text,
  password,
  phone,
  number,
}

class TextFieldIntro extends StatefulWidget {
  final String labelText;
  final Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final TextFieldIntroType type;
  final String? Function(String?)? validator;
  final Color fillColor;
  final Color textColor;

  const TextFieldIntro({
    this.labelText = '',
    this.onChanged,
    this.onSaved,
    this.type = TextFieldIntroType.text,
    this.validator,
    this.fillColor = Colors.white,
    this.textColor = Colors.black,
  });

  @override
  _TextFieldIntroState createState() => _TextFieldIntroState();
}

class _TextFieldIntroState extends State<TextFieldIntro> {
  bool passwordHide = true;
  togglePasswordHide() => setState(() => passwordHide = !passwordHide);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      obscureText: (widget.type == TextFieldIntroType.password) && passwordHide,
      keyboardType: widget.type == TextFieldIntroType.phone
          ? TextInputType.phone
          : widget.type == TextFieldIntroType.number
              ? TextInputType.number
              : TextInputType.text,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: widget.fillColor,
        errorStyle: TextStyle(
          fontSize: 14,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.red),
        ),
        suffixIcon: widget.type == TextFieldIntroType.password
            ? IconButton(
                onPressed: togglePasswordHide,
                icon: Icon(
                  passwordHide ? Icons.visibility : Icons.visibility_off,
                  color: Colors.orange.shade400,
                ),
              )
            : null,
      ),
      style: TextStyle(color: widget.textColor),
    );
  }
}
