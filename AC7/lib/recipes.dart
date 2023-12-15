import 'package:ac7/add_recipe.dart';
import 'package:flutter/material.dart';
import 'package:ac7/recipe_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RecipesView extends StatefulWidget {
  const RecipesView({Key? key}) : super(key: key);

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView>  {

  List<Recipe> recipes = List.empty(growable: true);

  String userMail = "usermail";

  @override
  void initState() {
    super.initState();

    getUserMail().then((value) {
      loadRecipes().first.then((value) {
        recipes = value;
        setState(() {});
      });
    });

  }

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
                MaterialPageRoute(
                    builder: (context) => AddRecipeView(
                      recipeAdded: (recipe) {
                        if (recipe.name.isNotEmpty && recipe.description.isNotEmpty) {
                          setState(() {
                            recipes.add(recipe);
                            addRecipe(recipe);
                          });
                        }
                      },
                    ),
                    ),
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

  Stream<List<Recipe>> loadRecipes() {
    return FirebaseFirestore.instance.collection(userMail).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Recipe.fromJson(doc.data())).toList();
    });
  }

  Future addRecipe(Recipe recipe) async {
    final docRecipe = FirebaseFirestore.instance.collection(userMail).doc(recipe.name);

    final json = recipe.toJson();

    await docRecipe.set(json);
  }

  //function to get current logged in user mail
  Future getUserMail() async {
    final user = FirebaseAuth.instance.currentUser;
    userMail = user!.email!;
    setState(() {
    });
  }

}


class Recipe {

  final String name;
  final String description;

  const Recipe({required this.name, required this.description});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }

  static Recipe fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      description: json['description'],
    );
  }

}
