import 'package:flutter/material.dart';
import 'auto_part.dart';

class EditPartPage extends StatefulWidget {
  final AutoPart part;
  final Function(AutoPart) onSave;

  const EditPartPage({super.key, required this.part, required this.onSave});

  @override
  _EditPartPageState createState() => _EditPartPageState();
}

class _EditPartPageState extends State<EditPartPage> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController imageUrlController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.part.name);
    descriptionController = TextEditingController(text: widget.part.description);
    imageUrlController = TextEditingController(text: widget.part.imageUrl);
    priceController = TextEditingController(text: widget.part.price.toString());
  }

  void save() {
    widget.part.name = nameController.text;
    widget.part.description = descriptionController.text;
    widget.part.imageUrl = imageUrlController.text;
    widget.part.price = double.tryParse(priceController.text) ?? 0;
    widget.onSave(widget.part);
    Navigator.pop(context);
  }



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редактирование товара')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Описание'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(labelText: 'URL изображения'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Цена'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: save,
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
