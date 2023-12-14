import 'package:ac7/recipes.dart';
import 'package:flutter/material.dart';


class AddRecipeView extends StatefulWidget {

  const AddRecipeView({super.key, required this.recipeAdded});


  final Function (Recipe recipe) recipeAdded;

  @override
  State<AddRecipeView> createState() => _AddRecipeViewState();

}

class _AddRecipeViewState extends State<AddRecipeView> {

  var nameField = TextEditingController();
  var descriptionField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Show the recipe name and the recipe description
      appBar: AppBar(
        title: Text("Add recipe"),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),

        child: Column(

          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Recipe name'),
              controller: nameField,
              maxLength: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Recipe description'),
              controller: descriptionField,
              maxLength: 40,
            ),
            //Button to add the recipe
            ElevatedButton(
              onPressed: () {
                //Add the recipe
                if (nameField.text.isNotEmpty && descriptionField.text.isNotEmpty) {
                  widget.recipeAdded(Recipe(name: nameField.text,
                      description: descriptionField.text));
                  //Go back to the previous screen
                  Navigator.pop(context);
                }
              },
              child: const Text('Add recipe'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

