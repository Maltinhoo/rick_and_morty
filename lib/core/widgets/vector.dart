// ignore_for_file: constant_identifier_names

import 'package:rick_and_morty/app_imports.dart';

enum Vectors { rick_morty, logo, close_outlined, close, add, filter }

class Vector extends StatelessWidget {
  final dynamic icon;
  final String? url;
  final double? size;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;
  final Alignment? alignment;
  final BlendMode? blendMode;

  const Vector(
    this.icon, {
    super.key,
    this.size,
    this.blendMode,
    this.color,
    this.fit,
    this.width,
    this.height,
    this.alignment,
  }) : url = null;

  const Vector.fromNetwork(
    this.url, {
    super.key,
    this.size,
    this.blendMode,
    this.color,
    this.fit,
    this.width,
    this.height,
    this.alignment,
  }) : icon = null;

  @override
  Widget build(BuildContext context) {
    if (icon == null && url == null) return Container();

    final iconPath = icon is IconData
        ? null
        : icon is String
        ? 'assets/icons/$icon.svg'
        : icon is Enum
        ? 'assets/icons/${(icon as Enum).name.toLowerCase()}.svg'
        : null;

    if (iconPath != null || icon is IconData) {
      final widget = icon is IconData
          ? Icon(icon, size: size, color: color)
          : SvgPicture.asset(
              iconPath!,
              alignment: alignment ?? Alignment.center,
              fit: fit ?? BoxFit.cover,
              width: width ?? size,
              height: height ?? size,
              colorFilter: color != null
                  ? ColorFilter.mode(
                      color ?? Colors.transparent,
                      blendMode ?? BlendMode.srcIn,
                    )
                  : null,
            );

      return url == null
          ? widget
          : SvgPicture.network(
              url!,
              alignment: alignment ?? Alignment.center,
              fit: fit ?? BoxFit.cover,
              width: width ?? size,
              height: height ?? size,
              colorFilter: color != null
                  ? ColorFilter.mode(
                      color ?? Colors.transparent,
                      blendMode ?? BlendMode.srcIn,
                    )
                  : null,
            );
    }

    return Container();
  }
}
