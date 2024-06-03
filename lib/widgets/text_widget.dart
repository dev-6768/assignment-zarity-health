import 'package:assignment_zarity_health/utils/constants.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final String text;
  final String fontFamily;
  final double size;
  const TextWidget({super.key, required this.text, required this.fontFamily, required this.size});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontFamily: widget.fontFamily,
        fontSize: widget.size,
      ),

    );
  }
}


class RichTextWidget extends StatefulWidget {
  final String text;
  final Color color;
  const RichTextWidget({super.key, required this.text, required this.color});

  @override
  State<RichTextWidget> createState() => _RichTextWidgetState();
}

class _RichTextWidgetState extends State<RichTextWidget> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: widget.text,
        style: TextStyle(
              fontFamily: ConstantUtils.appFontFamily,
              fontSize: ConstantUtils.appFontSize,
              color: widget.color,
            ),
      ),
    );
  }
}