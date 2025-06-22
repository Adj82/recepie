import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'recepie_model.dart';

class RecipeProvider with ChangeNotifier {
  final List<recepie> _recipes = [];
  final List<String> _savedRecipes = [];

  List<recepie> get recipes => _recipes;
  List<String> get savedRecipes => _savedRecipes;

  void addRecipe(recepie recepie) {
    _recipes.add(recepie);
    notifyListeners();
  }

  void toggleSave(String recipeName) {
    if (_savedRecipes.contains(recipeName)) {
      _savedRecipes.remove(recipeName);
    } else {
      _savedRecipes.add(recipeName);
    }
    notifyListeners();
  }

  bool isSaved(String recipeName) {
    return _savedRecipes.contains(recipeName);
  }
}

class recepie {
}


class BookmarkProvider with ChangeNotifier {
  final List<String> _savedRecipes = [];

  List<String> get savedRecipes => _savedRecipes;

  void toggleSave(String recipeName) {
    if (_savedRecipes.contains(recipeName)) {
      _savedRecipes.remove(recipeName);
    } else {
      _savedRecipes.add(recipeName);
    }
    notifyListeners();
  }

  bool isSaved(String recipeName) {
    return _savedRecipes.contains(recipeName);
  }
}
