import 'package:rick_and_morty/app_imports.dart';

class CustomShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;
  final bool enabled;
  final bool childShimmer;
  final Color? baseColor, highlightColor;
  final Duration period;
  final int loop;
  final ShimmerDirection direction;

  const CustomShimmer({
    super.key,
    this.height = 18,
    this.width = 100,
    this.radius = 2,
    this.borderRadius,
    this.child,
    this.enabled = true,
    this.childShimmer = false,
    this.baseColor,
    this.highlightColor,
    this.period = const Duration(milliseconds: 1500),
    this.loop = 0,
    this.direction = ShimmerDirection.ltr,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child ?? Container();
    } else if (childShimmer) {
      return Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey.shade300,
        highlightColor: highlightColor ?? Colors.grey.shade100,
        enabled: enabled,
        direction: direction,
        period: period,
        loop: loop,
        child: child ?? Container(),
      );
    }
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: highlightColor ?? Colors.grey.shade100,
      enabled: enabled,
      period: period,
      loop: loop,
      direction: direction,
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: borderRadius ?? BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
