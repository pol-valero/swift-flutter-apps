import 'package:ac7/recipes.dart';
import 'package:flutter/material.dart';


class RecipeInfoView extends StatefulWidget {

  const RecipeInfoView({super.key, required this.recipe});


  final Recipe recipe;

  @override
  State<RecipeInfoView> createState() => _RecipeInfoViewState();

}

class _RecipeInfoViewState extends State<RecipeInfoView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Show the recipe name and the recipe description
      appBar: AppBar(
        title: Text(widget.recipe.name),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(widget.recipe.description),
          ],
        ),
      ),
    );
  }
}

