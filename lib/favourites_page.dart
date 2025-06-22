import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider.dart';
import 'recepie_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  // If you have a global recipeData map, use it here.
  // This example uses a hardcoded map for demo purposes.
  // Replace with your own data or fetch from a provider.
  final Map<String, Map<String, String>> recipeData = {
    'Creamy Tomato Pasta': {
      'image': 'https://tinyurl.com/4dfu5ku2',
      'prepTime': '20 mins',
    },
    'Fresh Garden Salad': {
      'image': 'https://tinyurl.com/2kna9pcn',
      'prepTime': '10 mins',
    },
  };

  @override
  Widget build(BuildContext context) {
    final savedRecipes = Provider.of<BookmarkProvider>(context).savedRecipes;

    if (savedRecipes.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          backgroundColor: const Color(0xFFF8F5F2),
          elevation: 0,
          centerTitle: true,
        ),
        body: const Center(
          child: Text('No favorite recipes yet.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: const Color(0xFFF8F5F2),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: savedRecipes.length,
        itemBuilder: (context, index) {
          final recipeName = savedRecipes[index];
          final recipe = recipeData[recipeName];
          if (recipe == null) return const SizedBox.shrink();
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  recipe['image']!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.food_bank, size: 30),
                ),
              ),
              title: Text(recipeName),
              subtitle: Text('Prep Time: ${recipe['prepTime']}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipeDetailPage(recipeName: recipeName),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
