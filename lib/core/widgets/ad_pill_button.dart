import 'package:rick_and_morty/app_imports.dart';

class FilterPillButton extends StatelessWidget {
  final Function()? onTap;
  final bool isSelected;
  final String label;
  const FilterPillButton({
    super.key,
    this.onTap,
    this.isSelected = false,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100),
      color: isSelected ? AppColors.darkAtlantis : AppColors.primaryLight,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                label,
                color: AppColors.white,
                fontWeight: FontWeight.w800,
                conversion: ConversionType.capitalize,
              ),
              Gap(10),
              Vector(isSelected ? Vectors.close : Vectors.add),
            ],
          ),
        ),
      ),
    );
  }
}
