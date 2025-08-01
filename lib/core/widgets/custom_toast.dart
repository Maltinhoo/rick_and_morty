import 'dart:developer';

import 'package:rick_and_morty/app_imports.dart';

class CustomToast extends StatelessWidget {
  static OKToast parent({required Widget child}) {
    return OKToast(child: child);
  }

  static ToastFuture? success(BuildContext context, String message) {
    return show(
      context,
      CustomToast(
        backgroundColor: AppColors.success,
        icon: Icons.check_circle,
        message: message,
        textColor: Colors.white,
      ),
    );
  }

  static ToastFuture? error(BuildContext context, String message) {
    return show(
      context,
      CustomToast(
        backgroundColor: AppColors.danger,
        icon: Icons.cancel,
        message: message,
        textColor: Colors.white,
      ),
    );
  }

  static ToastFuture? alert(BuildContext context, String message) {
    return show(
      context,
      CustomToast(
        backgroundColor: AppColors.alert,
        icon: Icons.info,
        message: message,
        textColor: Colors.white,
      ),
    );
  }

  static ToastFuture? show(BuildContext context, CustomToast toast) {
    try {
      dismissAllToast(showAnim: true);
      return showToastWidget(
        toast,
        dismissOtherToast: true,
        position: ToastPosition.bottom,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      log("$e");
    }
    return null;
  }

  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final String message;

  const CustomToast({
    super.key,
    required this.message,
    this.icon,
    this.backgroundColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.gray,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...{
            Icon(icon, color: textColor),
            SizedBox(width: 12),
          },
          Expanded(
            child: CustomText(
              message,
              textStyle: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: textColor),
              textAlign: icon != null ? TextAlign.left : TextAlign.center,
              maxLines: 5,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
