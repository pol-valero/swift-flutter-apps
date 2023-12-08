import 'package:flutter/material.dart';

//TODO: Do the class properly is only for testing purposes (redirecting to recipes view)
class RecipesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: Center(
        child: Text('Recipes View'),
      ),
    );
  }
}
