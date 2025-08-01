import 'package:rick_and_morty/app_imports.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity char;
  final Function(CharacterEntity)? onTap;
  const CharacterCard({super.key, required this.char, this.onTap});

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onTap != null ? () => onTap!(char) : null,
        borderRadius: BorderRadius.circular(15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (kIsWeb)
                  Expanded(
                    child: CustomImage(
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: char.imageUrl,
                    ),
                  )
                else
                  CustomImage(
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: char.imageUrl,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        char.name,
                        maxLines: 1,
                        fontWeight: FontWeight.w800,
                        size: 28,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: getStatusColor(char.status),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          CustomText(
                            '${char.status} - ${char.species}',
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomText(
                        'Last known location:',
                        size: 14,
                        color: Colors.white60,
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        'Earth (Replacement Dimension)',
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      CustomText(
                        'First seen in:',
                        size: 14,
                        color: Colors.white60,
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        'Morty\'s Mind Blowers',
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
