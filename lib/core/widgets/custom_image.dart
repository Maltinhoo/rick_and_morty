import 'package:rick_and_morty/app_imports.dart';

class CustomImage extends StatelessWidget {
  final bool local;
  final String image;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final Alignment? alignment;
  final Color? color;
  final BlendMode? colorBlendMode;
  final double? opacity;
  final Widget Function(BuildContext, String, DownloadProgress)?
  progressIndicatorBuilder;
  final BorderRadiusGeometry? borderRadius;
  final String? fallbackSvgAsset;
  final String? fallbackPngAsset;

  const CustomImage({
    super.key,
    this.local = false,
    required this.image,
    this.fit,
    this.height,
    this.width,
    this.placeholder,
    this.errorWidget,
    this.alignment,
    this.progressIndicatorBuilder,
    this.color,
    this.colorBlendMode,
    this.opacity,
    this.borderRadius,
    this.fallbackSvgAsset,
    this.fallbackPngAsset,
  });

  static List<String> reportedImageUrlsWithError = [];

  static void reportError(String imageUrl, exception, stackTrace) {
    if (reportedImageUrlsWithError.contains(imageUrl)) {
      return;
    }

    reportedImageUrlsWithError.add(imageUrl);

    if (kIsWeb) {
      debugPrint("Error loading local image on web: $imageUrl");
      return;
    } else {
      debugPrint("Error loading local image: $imageUrl");
    }
  }

  Widget defaultErrorWidget(BuildContext context) {
    if (fallbackSvgAsset != null) {
      return SvgPicture.asset(
        fallbackSvgAsset!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.contain,
      );
    } else if (fallbackPngAsset != null) {
      return Image.asset(
        fallbackPngAsset!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.contain,
      );
    }
    return const Icon(Icons.image);
  }

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return SizedBox(
        height: height,
        width: width,
        child: errorWidget != null
            ? errorWidget!(context, "", "")
            : defaultErrorWidget(context),
      );
    }

    if (local) {
      return Opacity(
        opacity: opacity ?? 1,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          child: Image.asset(
            'assets/images/$image',
            fit: fit,
            alignment: alignment ?? Alignment.center,
            height: height,
            width: width,
            filterQuality: FilterQuality.high,
            errorBuilder: (context, obj, stack) {
              return errorWidget != null
                  ? errorWidget!(context, obj.toString(), stack)
                  : defaultErrorWidget(context);
            },
            color: color,
            colorBlendMode: colorBlendMode,
          ),
        ),
      );
    }

    return Opacity(
      opacity: opacity ?? 1,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: CachedNetworkImage(
          filterQuality: FilterQuality.high,
          imageUrl: image.isNotEmpty ? image : "",
          fit: fit,
          height: height,
          alignment: alignment ?? Alignment.center,
          width: width,
          placeholder: (context, url) {
            return placeholder != null
                ? placeholder!(context, url)
                : CustomShimmer(
                    height: height ?? 100,
                    width: width ?? 100,
                    borderRadius: borderRadius,
                  );
          },
          errorWidget: (context, obj, stack) {
            reportError(image, obj, stack);
            return errorWidget != null
                ? errorWidget!(context, obj, stack)
                : defaultErrorWidget(context);
          },
          progressIndicatorBuilder: progressIndicatorBuilder,
          color: color,
          colorBlendMode: colorBlendMode,
        ),
      ),
    );
  }
}
