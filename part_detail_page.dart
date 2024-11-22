import 'package:flutter/material.dart';
import 'auto_part.dart';
import 'edit_part_page.dart';


class PartDetailPage extends StatelessWidget {
  final AutoPart part;
  final Function(AutoPart) onEdit;

  const PartDetailPage({super.key, required this.part, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(part.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(part.imageUrl),
            const SizedBox(height: 16),
            Text(
              part.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              part.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Цена: ${part.price} ₽',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPartPage(
                    part: part,
                    onSave: (editedPart) {
                      onEdit(editedPart);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
            child: const Text('Редактировать'),
          ),

          ],
        ),
      ),
    );
  }
}
