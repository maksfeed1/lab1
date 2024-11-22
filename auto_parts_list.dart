import 'package:flutter/material.dart';
import 'api_service.dart';
import 'edit_part_page.dart';
import 'favorites_page.dart';
import 'part_detail_page.dart';
import 'auto_part.dart';
import 'app_styles.dart';  // Импортируем стили

class AutoPartsList extends StatefulWidget {
  const AutoPartsList({super.key});

  @override
  _AutoPartsListState createState() => _AutoPartsListState();
}

class _AutoPartsListState extends State<AutoPartsList> {
  List<AutoPart> autoParts = [];
  List<AutoPart> favorites = [];
  bool isLoading = true;
  final apiService = ApiService();
  
  // Для сортировки
  String selectedSortOption = 'По имени'; // По умолчанию сортировка по имени

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);
    try {
      autoParts = await apiService.fetchAutoParts();
      applySort(); // Сразу применяем сортировку после загрузки
    } catch (e) {
      print('Ошибка загрузки данных: $e');
    }
    setState(() => isLoading = false);
  }

  void applySort() {
    setState(() {
      if (selectedSortOption == 'По имени') {
        autoParts.sort((a, b) => a.name.compareTo(b.name));
      } else if (selectedSortOption == 'По описанию') {
        autoParts.sort((a, b) => a.description.compareTo(b.description));
      }
    });
  }

  void updateSortOption(String option) {
    setState(() {
      selectedSortOption = option;
      applySort(); // Применяем сортировку при выборе новой опции
    });
  }

  void updatePart(AutoPart updatedPart) async {
    await apiService.updateAutoPart(updatedPart);
    loadData();
  }

  void toggleFavorite(AutoPart part) {
    setState(() {
      if (favorites.contains(part)) {
        favorites.remove(part);
      } else {
        favorites.add(part);
      }
    });
  }

  void openFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesPage(
          favorites: favorites,
          onFavoritesUpdated: (updatedFavorites) {
            setState(() {
              favorites = updatedFavorites;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Автозапчасти'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: openFavorites,
          ),
        ],
      ),
      body: Column(
        children: [
          // Секция выбора сортировки
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Сортировать по:',
                  style: AppStyles.titleTextStyle,  // Используем стиль для заголовков
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text('По имени', style: AppStyles.radioTextStyle), // Используем стиль для радио-кнопок
                        leading: Radio<String>(
                          value: 'По имени',
                          groupValue: selectedSortOption,
                          onChanged: (value) => updateSortOption(value!),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text('По описанию', style: AppStyles.radioTextStyle), // Используем стиль для радио-кнопок
                        leading: Radio<String>(
                          value: 'По описанию',
                          groupValue: selectedSortOption,
                          onChanged: (value) => updateSortOption(value!),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Список деталей
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: autoParts.length,
                    itemBuilder: (context, index) {
                      final part = autoParts[index];
                      final isFavorite = favorites.contains(part);
                      return ListTile(
                        leading: Image.network(part.imageUrl),
                        title: Text(part.name, style: AppStyles.titleTextStyle),  // Используем стиль для заголовков
                        subtitle: Text('Описание: ${part.description}', style: AppStyles.subtitleTextStyle), // Используем стиль для подзаголовков
                        trailing: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            color: isFavorite ? Colors.yellow : Colors.grey,
                          ),
                          onPressed: () => toggleFavorite(part),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PartDetailPage(
                                part: part,
                                onEdit: (updatedPart) {
                                  updatePart(updatedPart);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditPartPage(
                part: AutoPart(
                  name: '',
                  description: '',
                  imageUrl: '',
                  price: 0.0,
                ),
                onSave: (newPart) async {
                  await apiService.createAutoPart(newPart); // Важно добавить вызов сохранения через API
                  setState(() {
                    autoParts.add(newPart);
                    applySort(); // Применяем сортировку после добавления нового элемента
                  });
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
