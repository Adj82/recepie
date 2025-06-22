import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'recepie_model.dart';
import 'provider.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  final _descController = TextEditingController();
  final _ingredientController = TextEditingController();
  final _instructionController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _fatController = TextEditingController();
  final _proteinController = TextEditingController();

  List<String> _ingredients = [];
  List<String> _instructions = [];

  @override
  void dispose() {
    _nameController.dispose();
    _imageController.dispose();
    _descController.dispose();
    _ingredientController.dispose();
    _instructionController.dispose();
    _caloriesController.dispose();
    _fatController.dispose();
    _proteinController.dispose();
    super.dispose();
  }

  void _addIngredient() {
    if (_ingredientController.text.isNotEmpty) {
      setState(() {
        _ingredients.add(_ingredientController.text);
        _ingredientController.clear();
      });
    }
  }

  void _addInstruction() {
    if (_instructionController.text.isNotEmpty) {
      setState(() {
        _instructions.add(_instructionController.text);
        _instructionController.clear();
      });
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  void _removeInstruction(int index) {
    setState(() {
      _instructions.removeAt(index);
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate() &&
        _ingredients.isNotEmpty &&
        _instructions.isNotEmpty) {
      final recipe = Recipe(
        name: _nameController.text,
        image: _imageController.text,
        description: _descController.text,
        ingredients: List.from(_ingredients),
        instructions: List.from(_instructions),
        nutrition: {
          'Calories': _caloriesController.text,
          'Fat': _fatController.text,
          'Protein': _proteinController.text,
        },
      );
      Provider.of<RecipeProvider>(context, listen: false).addRecipe(recepie as recepie);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields and add at least one ingredient and instruction.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Recipe'),
        backgroundColor: const Color(0xFFF8F5F2),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Recipe Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter recipe name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter image URL' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter description' : null,
              ),
              const SizedBox(height: 16),
              const Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _ingredients.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_ingredients[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeIngredient(index),
                    ),
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _ingredientController,
                      decoration: const InputDecoration(
                        labelText: 'Add Ingredient',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addIngredient,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Instructions:', style: TextStyle(fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _instructions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Step ${index + 1}: ${_instructions[index]}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeInstruction(index),
                    ),
                  );
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _instructionController,
                      decoration: const InputDecoration(
                        labelText: 'Add Instruction',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addInstruction,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Nutrition:', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _caloriesController,
                decoration: const InputDecoration(
                  labelText: 'Calories',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter calories' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _fatController,
                decoration: const InputDecoration(
                  labelText: 'Fat',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter fat' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _proteinController,
                decoration: const InputDecoration(
                  labelText: 'Protein',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Enter protein' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Create Recipe'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
