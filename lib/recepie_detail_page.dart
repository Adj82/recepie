import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider.dart';

class RecipeDetailPage extends StatefulWidget {
  final String recipeName;
  const RecipeDetailPage({super.key, required this.recipeName});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  final Map<String, dynamic> recipeData = {
    'Creamy Tomato Pasta': {
      'image': 'https://tinyurl.com/4dfu5ku2',
      'desc': 'A simple yet delicious pasta dish with a rich, creamy tomato sauce. Perfect for a quick weeknight dinner.',
      'ingredients': [
        '1 lb pasta',
        '1 cup heavy cream',
        '1 can crushed tomatoes',
        '1/2 cup grated Parmesan cheese',
        '2 cloves garlic, minced'
      ],
      'instructions': [
        'Cook pasta according to package instructions.',
        'In a saucepan, heat cream and tomatoes. Add garlic and simmer for 6 minutes.',
        'Stir in Parmesan cheese until melted.',
        'Combine sauce with cooked pasta. Serve hot.',
      ],
      'nutrition': {
        'Calories': '450',
        'Fat': '20g',
        'Protein': '15g',
      },
    },
    'Fresh Garden Salad': {
      'image': 'https://tinyurl.com/2kna9pcn',
      'desc': 'A crisp, refreshing salad with seasonal vegetables and a light dressing.',
      'ingredients': [
        '1 head lettuce',
        '1 cucumber',
        '2 tomatoes',
        '1/4 red onion',
        '1/2 cup croutons',
        '2 tbsp olive oil',
        'Salt and pepper to taste'
      ],
      'instructions': [
        'Chop lettuce, cucumber, tomatoes, and onion.',
        'Toss with croutons.',
        'Drizzle with olive oil and season with salt and pepper.',
      ],
      'nutrition': {
        'Calories': '250',
        'Fat': '10g',
        'Protein': '6g',
      },
    },
  };

  late List<bool> _checked;

  @override
  void initState() {
    super.initState();
    final recipe = recipeData[widget.recipeName];
    _checked = List.filled(recipe?['ingredients']?.length ?? 0, false);
  }

  @override
  Widget build(BuildContext context) {
    final recipe = recipeData[widget.recipeName];
    if (recipe == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Recipe not found')),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Consumer<BookmarkProvider>(
            builder: (context, bookmarkProvider, child) {
              return IconButton(
                icon: Icon(
                  bookmarkProvider.isSaved(widget.recipeName)
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: Colors.black87,
                ),
                onPressed: () {
                  bookmarkProvider.toggleSave(widget.recipeName);
                },
              );
            },
          ),
        ],

        backgroundColor: const Color(0xFFF8F5F2),
        elevation: 0,
        centerTitle: true,
        title: const Text(''),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              recipe['image'],
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: double.infinity,
                height: 180,
                color: Colors.grey[200],
                child: const Icon(Icons.food_bank, size: 60),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.recipeName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(height: 8),
          Text(
            recipe['desc'],
            style: const TextStyle(fontSize: 15, color: Colors.black87),
          ),
          const SizedBox(height: 18),
          const Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          ...List.generate(recipe['ingredients'].length, (i) {
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: _checked[i],
              onChanged: (val) {
                setState(() => _checked[i] = val!);
              },
              title: Text(recipe['ingredients'][i], style: const TextStyle(fontSize: 15)),
            );
          }),
          const SizedBox(height: 10),
          const Text('Instructions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          ...List.generate(recipe['instructions'].length, (i) {
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 2),
              child: Text(
                'Step ${i + 1}\n${recipe['instructions'][i]}',
                style: const TextStyle(fontSize: 15),
              ),
            );
          }),
          const SizedBox(height: 14),
          const Text('Nutrition', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          ...recipe['nutrition'].entries.map((e) => Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text('${e.key}: ${e.value}', style: const TextStyle(fontSize: 15)),
          )),
        ],
      ),
    );
  }
}
