class Recipe {
  final String name;
  final String image;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final Map<String, String> nutrition;

  Recipe({
    required this.name,
    required this.image,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.nutrition,
  });
}
