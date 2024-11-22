import 'package:flutter/material.dart';
import 'auto_part.dart';

class FavoritesPage extends StatefulWidget {
  final List<AutoPart> favorites;
  final Function(List<AutoPart>) onFavoritesUpdated;

  const FavoritesPage({
    super.key,
    required this.favorites,
    required this.onFavoritesUpdated,
  });

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<AutoPart> selectedParts = []; // Список выбранных деталей

  // Выбираем или отменяем выбор всех деталей
  void toggleSelectAll(bool? isSelected) {
    setState(() {
      if (isSelected ?? false) {
        selectedParts = List.from(widget.favorites);
      } else {
        selectedParts.clear();
      }
    });
  }

  // Обновляем состояние для каждой детали
  void toggleSelection(AutoPart part) {
    setState(() {
      if (selectedParts.contains(part)) {
        selectedParts.remove(part);
      } else {
        selectedParts.add(part);
      }
    });
  }

  // Удаляем выбранные детали
  void deleteSelectedParts() {
    setState(() {
      widget.favorites.removeWhere((part) => selectedParts.contains(part));
      selectedParts.clear();
    });
    widget.onFavoritesUpdated(widget.favorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        actions: [
          Checkbox(
            value: selectedParts.length == widget.favorites.length && widget.favorites.isNotEmpty,
            onChanged: toggleSelectAll,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: selectedParts.isNotEmpty ? deleteSelectedParts : null,
          ),
        ],
      ),
      body: widget.favorites.isEmpty
          ? const Center(child: Text('Избранных товаров пока нет'))
          : ListView.builder(
              itemCount: widget.favorites.length,
              itemBuilder: (context, index) {
                final part = widget.favorites[index];
                final isSelected = selectedParts.contains(part);

                return ListTile(
                  leading: Image.network(part.imageUrl),
                  title: Text(part.name),
                  subtitle: Text('Цена: ${part.price} ₽'),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (_) => toggleSelection(part),
                  ),
                  onTap: () => toggleSelection(part),
                );
              },
            ),
    );
  }
}
