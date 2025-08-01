import 'package:rick_and_morty/app_imports.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final double? size;
  final double minSize;
  final Color? color;
  final String? fontFamily;
  final Gradient? gradient;
  final TextDecoration? decoration;
  final List<Shadow>? shadows;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final EdgeInsets? margin;
  final EdgeInsets padding;
  final double? letterSpacing;
  final double? height;
  final ConversionType conversion;
  final TextDirection? textDirection;

  final bool autosize;
  final AutoSizeGroup? group;
  final bool? softWrap;

  const CustomText(
    this.text, {
    super.key,
    this.textStyle,
    this.fontWeight,
    this.size,
    this.minSize = 10,
    this.color,
    this.fontFamily,
    this.gradient,
    this.decoration,
    this.shadows,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.margin,
    this.padding = const EdgeInsets.all(0),
    this.letterSpacing,
    this.height,
    this.conversion = ConversionType.none,
    this.autosize = true,
    this.group,
    this.textDirection,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    assert(
      color == null || gradient == null,
      'Use either a gradient or a color',
    );

    TextStyle? style = textStyle ?? Theme.of(context).textTheme.bodyLarge!;

    style = style.copyWith(
      fontSize: size ?? style.fontSize,
      color: color ?? style.color,
      fontFamily: fontFamily ?? style.fontFamily,
      fontWeight: fontWeight ?? style.fontWeight,
      shadows: shadows ?? style.shadows,
      decoration: decoration ?? style.decoration,
      letterSpacing: letterSpacing ?? style.letterSpacing,
      height: height ?? style.height,
    );

    return Padding(padding: margin ?? padding, child: _buildText(style));
  }

  String get getText {
    switch (conversion) {
      case ConversionType.toUpperCase:
        return text.toUpperCase();
      case ConversionType.toLowerCase:
        return text.toLowerCase();
      case ConversionType.capitalize:
        return text.capitalize();
      default:
        return text;
    }
  }

  Widget _buildText(TextStyle? style) {
    var textWidget = autosize
        ? AutoSizeText(
            getText,
            softWrap: softWrap,
            style: style,
            textAlign: textAlign,
            minFontSize: minSize,
            overflow: overflow,
            maxLines: maxLines,
            group: group,
            textDirection: textDirection,
          )
        : Text(
            getText,
            style: style,
            softWrap: softWrap,
            textAlign: textAlign,
            overflow: overflow,
            maxLines: maxLines,
            textDirection: textDirection,
          );

    return gradient != null
        ? ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (rect) => gradient!.createShader(rect),
            child: textWidget,
          )
        : textWidget;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

enum ConversionType { toUpperCase, toLowerCase, capitalize, none }
