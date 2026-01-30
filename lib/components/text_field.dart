import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String title;
  final TextEditingController? inputController;
  final TextInputType? keyboardType;

  const InputTextField({super.key, required this.title, this.inputController, this.keyboardType = TextInputType.multiline});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: TextField(
        minLines: 1,
        maxLines: 3,
        keyboardType: keyboardType,
        controller: inputController,
        decoration: InputDecoration(
          // filled: true,
          // fillColor: Colors.red,
          labelText: title,
          // Default border when the TextField is enabled but not focused
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(
                0xFFDDDCDC,
              ), // Your desired color for the enabled state
              width: 1.0,
            ),
          ),
          // Border when the TextField is focused
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue, // Your desired color for the focused state
              width: 1.5,
            ),
          ),
          // Border when there's an error and the TextField is not focused
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red, // Your desired color for the error state
              width: 1.0,
            ),
          ),
          // Border when there's an error and the TextField is focused
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors
                  .redAccent, // Your desired color for focused error state
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

class InputTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController inputController;

  const InputTextFormField({
    super.key,
    required this.title,
    required this.inputController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$title is required";
        }
        return null;
      },
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(10),
        labelText: title,
        // Default border when the TextField is enabled but not focused
        enabledBorder: OutlineInputBorder(

          borderSide: BorderSide(
            color: Color(
              0xFFDDDCDC,
            ), // Your desired color for the enabled state
            width: 1.0,
          ),
        ),
        // Border when the TextField is focused
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue, // Your desired color for the focused state
            width: 1.5,
          ),
        ),
        // Border when there's an error and the TextField is not focused
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red, // Your desired color for the error state
            width: 1.0,
          ),
        ),
        // Border when there's an error and the TextField is focused
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors
                .redAccent, // Your desired color for focused error state
            width: 2.0,
          ),
        ),
      ),
    );
  }
}


class DateTimeTextField extends StatelessWidget {
  final String title;
  final TextEditingController? inputController;
  final VoidCallback? onTap;

  const DateTimeTextField({super.key, required this.title, this.inputController, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: TextField(
        onTap: onTap,
        readOnly: true,
        controller: inputController,
        decoration: InputDecoration(
          // filled: true,
          // fillColor: Colors.red,
          labelText: title,
          // Default border when the TextField is enabled but not focused
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(
                0xFFDDDCDC,
              ), // Your desired color for the enabled state
              width: 1.0,
            ),
          ),
          // Border when the TextField is focused
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue, // Your desired color for the focused state
              width: 1.5,
            ),
          ),
          // Border when there's an error and the TextField is not focused
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red, // Your desired color for the error state
              width: 1.0,
            ),
          ),
          // Border when there's an error and the TextField is focused
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors
                  .redAccent, // Your desired color for focused error state
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}

