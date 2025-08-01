import 'dart:ui';

import 'package:rick_and_morty/app_imports.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool enabled;
  final Color? color;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final TextStyle? textStyle;
  final TextDirection? textDirection;
  final Gradient? gradient;
  final Widget? prefix;
  final Widget? suffix;
  final bool isSquare;
  final bool outlined;
  final bool vertical;
  final EdgeInsets? padding;
  final bool borderDotted;

  const CustomButton({
    super.key,
    this.icon,
    this.label,
    this.onTap,
    this.width,
    this.height,
    this.enabled = true,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.textStyle,
    this.textDirection,
    this.gradient,
    this.prefix,
    this.suffix,
    this.isSquare = false,
    this.outlined = false,
    this.vertical = false,
    this.padding,
    this.borderDotted = false,
  }) : assert(!(icon == null && label == null));

  Color get _getColorEnabled {
    if (!enabled) {
      return AppColors.lightGray;
    }
    return outlined ? Colors.transparent : (color ?? AppColors.primaryLight);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          if (borderDotted)
            Positioned.fill(
              child: CustomPaint(
                painter: DottedBorderPainter(
                  color: borderColor ?? AppColors.inputBorder,
                  borderRadius: borderRadius ?? BorderRadius.circular(10),
                ),
              ),
            ),
          Material(
            color: gradient == null
                ? outlined
                      ? Colors.transparent
                      : _getColorEnabled
                : Colors.transparent,
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            child: InkWell(
              onTap: enabled ? onTap : null,
              borderRadius: borderRadius ?? BorderRadius.circular(10),
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: borderRadius ?? BorderRadius.circular(10),
                  border: borderColor != null || outlined
                      ? Border.all(
                          color: borderColor ?? AppColors.inputBorder,
                          width: outlined ? 2 : 0,
                        )
                      : null,
                ),
                padding:
                    padding ??
                    (isSquare
                        ? EdgeInsets.all(12)
                        : EdgeInsets.symmetric(vertical: 15.5, horizontal: 20)),
                child: Flex(
                  direction: vertical ? Axis.vertical : Axis.horizontal,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (prefix != null) ...[
                      FittedBox(fit: BoxFit.scaleDown, child: prefix!),
                      Gap(vertical ? 10 : 16),
                    ],
                    if (icon != null) ...[
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: icon ?? const SizedBox.shrink(),
                      ),
                      if (label != null) Gap(vertical ? 10 : 8),
                    ],
                    if (label != null)
                      Flexible(
                        child: CustomText(
                          label!,
                          textAlign: TextAlign.center,
                          textDirection: textDirection,
                          textStyle:
                              textStyle ??
                              TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: enabled
                                    ? (outlined
                                          ? AppColors.darkGray
                                          : AppColors.white)
                                    : AppColors.label,
                              ),
                        ),
                      ),
                    if (suffix != null) ...[
                      Gap(16),
                      FittedBox(fit: BoxFit.scaleDown, child: suffix!),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final BorderRadius borderRadius;

  DottedBorderPainter({
    required this.color,
    this.strokeWidth = 2.0,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 5.0;
    const double dashSpace = 3.0;
    final RRect rrect = borderRadius.toRRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );

    Path path = Path()..addRRect(rrect);
    Path dashPath = Path();

    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        Path? extractPath = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        dashPath.addPath(extractPath, Offset.zero);
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
