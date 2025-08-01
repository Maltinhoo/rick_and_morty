import 'dart:async';

import 'package:rick_and_morty/app_imports.dart';

class CustomTextField extends StatefulWidget {
  final String? hint, label;
  final Function(String?)? validator;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Color? borderColor;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final Widget? suffixIcon, prefixIcon;
  final bool obscureText;
  final bool? enabled;
  final Color? hintColor;
  final InputBorder? border;
  final Color? fillColor;
  final TextStyle? style;
  final Widget? labelIcon;
  final int maxLines;
  final String? fontFamily;
  final EdgeInsetsGeometry? contentPadding;
  final bool useDebounce;
  final int debounceMilliseconds;

  const CustomTextField({
    super.key,
    this.hint,
    this.validator,
    this.controller,
    this.onChanged,
    this.label,
    this.borderColor,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.inputFormatters,
    this.initialValue,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled,
    this.hintColor,
    this.prefixIcon,
    this.border,
    this.fillColor,
    this.style,
    this.labelIcon,
    this.maxLines = 1,
    this.fontFamily,
    this.contentPadding,
    this.useDebounce = false,
    this.debounceMilliseconds = 500,
  });

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  Timer? _debounce;

  void _onChangedHandler(String value) {
    if (widget.useDebounce) {
      _debounce?.cancel();
      _debounce = Timer(
        Duration(milliseconds: widget.debounceMilliseconds),
        () {
          widget.onChanged?.call(value);
        },
      );
    } else {
      widget.onChanged?.call(value);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                widget.label!,
                color: AppColors.label,
                fontFamily: widget.fontFamily,
                size: 14,
                fontWeight: FontWeight.w600,
              ),
              if (widget.labelIcon != null) ...[Gap(8), widget.labelIcon!],
            ],
          ),
          Gap(10),
        ],
        TextFormField(
          maxLines: widget.maxLines,
          enabled: widget.enabled,
          obscureText: widget.obscureText,
          initialValue: widget.initialValue,
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          focusNode: widget.focusNode,
          onChanged: _onChangedHandler,
          controller: widget.controller,
          style:
              widget.style ??
              TextStyle(
                fontSize: 14,
                fontFamily: widget.fontFamily,
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w600,
              ),
          validator: (value) => widget.validator?.call(value),
          decoration: InputDecoration(
            fillColor: widget.fillColor ?? AppColors.white,
            filled: true,
            labelStyle: widget.style,
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            isDense: true,
            errorMaxLines: 3,
            errorStyle: TextStyle(
              fontSize: 12,
              fontFamily: widget.fontFamily,
              fontWeight: FontWeight.w600,
              color: AppColors.danger,
            ),
            hintText: widget.hint,
            hintStyle:
                widget.style ??
                TextStyle(
                  fontSize: 14,
                  fontFamily: widget.fontFamily,
                  color: widget.hintColor ?? AppColors.primaryDark,
                  fontWeight: FontWeight.w600,
                ),
            disabledBorder:
                widget.border ??
                OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
            border:
                widget.border ??
                OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
            enabledBorder:
                widget.border ??
                OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
            focusedBorder:
                widget.border ??
                OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
            suffixIcon: widget.suffixIcon,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 15, right: 5),
              child: widget.prefixIcon,
            ),
            prefixIconConstraints: const BoxConstraints(
              minHeight: 16,
              minWidth: 16,
            ),
          ),
        ),
      ],
    );
  }
}
