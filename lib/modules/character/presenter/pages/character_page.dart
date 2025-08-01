// ignore_for_file: deprecated_member_use

import 'package:rick_and_morty/app_imports.dart';

class CharacterPage extends StatelessWidget {
  static const name = '/character';
  final CharacterEntity char;

  const CharacterPage({super.key, required this.char});

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
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: CustomText(
                char.name,
                size: 32,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CustomImage(image: char.imageUrl, fit: BoxFit.cover),
                  Container(color: Colors.black.withOpacity(0.3)),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    "Status",
                    char.status,
                    color: getStatusColor(char.status),
                  ),
                  _buildInfoRow("Species", char.species),
                  if (char.type.isNotEmpty) _buildInfoRow("Type", char.type),
                  _buildInfoRow("Gender", char.gender),
                  _buildInfoRow("Created", char.created),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: color ?? Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
