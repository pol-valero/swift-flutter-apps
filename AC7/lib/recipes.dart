import 'package:flutter/material.dart';
import 'package:ac7/recipe_info.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({Key? key}) : super(key: key);

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView>  {

  var recipes = [
    const Recipe(
      name: 'Recipe 1',
      description: 'Description',
    ),
    const Recipe(
      name: 'Recipe 2',
      description: 'Description22',
    ),
    const Recipe(
      name: 'Recipe 3',
      description: 'Description',
    ),
    const Recipe(
      name: 'Recipe 4',
      description: 'Description',
    ),
    const Recipe(
      name: 'Recipe 5',
      description: 'Description',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RecipesView()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Container(
                height: 100,
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipes[index].name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            recipes[index].description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset('assets/recipe_img.png'),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecipeInfoView(recipe: recipes[index]),
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }
}

class Recipe {

  final String name;
  final String description;

  const Recipe({required this.name, required this.description});
}
