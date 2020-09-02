import 'package:E_commerce/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldClass extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String validateHint;
  final IconData suffixIcon;
  final IconData prefixIcon;
  final Function onSavedFun;
  final String initialValue;

  TextFieldClass(
      {@required this.labelText,
      @required this.hintText,
      @required this.validateHint,
      @required this.prefixIcon,
      @required this.onSavedFun,
      this.suffixIcon,
      this.initialValue});

  static IconData _passwordIcon = Icons.visibility;
  static bool _obscureValue = true;
  @override
  _TextFieldClassState createState() => _TextFieldClassState();
}

class _TextFieldClassState extends State<TextFieldClass> {
  TextStyle hintStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: NOTE_COLOR);

  TextStyle contentStyle = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w500, color: FIELD_CONTENT_COLOR);

  TextStyle labelStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: LIGHT_BLACK);
  @override
  void initState() {
    TextFieldClass._obscureValue = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSavedFun,
      obscureText:
          widget.labelText != "Password" ? false : TextFieldClass._obscureValue,
      validator: (value) {
        if (value.isEmpty) {
          return widget.validateHint;
        } else {
          return null;
        }
      },
      initialValue: widget.initialValue,
      style: contentStyle,
      decoration: InputDecoration(
        errorStyle: TextStyle(
            color: GRADIENT_END,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.8),
        labelText: widget.labelText,
        labelStyle: labelStyle,
        hintText: widget.hintText,
        hintStyle: hintStyle,
        prefixIcon: Icon(
          widget.prefixIcon,
          color: LIGHT_BLACK,
        ),
        suffixIcon: widget.labelText != "Password"
            ? null
            : IconButton(
                icon: Icon(TextFieldClass._passwordIcon),
                onPressed: onPressedVisibilityIcon),
      ),
    );
  }

  onPressedVisibilityIcon() {
    if (TextFieldClass._passwordIcon == Icons.visibility) {
      setState(() {
        TextFieldClass._passwordIcon = Icons.visibility_off;
        TextFieldClass._obscureValue = false;
      });
    } else if (TextFieldClass._passwordIcon == Icons.visibility_off) {
      setState(() {
        TextFieldClass._passwordIcon = Icons.visibility;
        TextFieldClass._obscureValue = true;
      });
    }
  }
}
