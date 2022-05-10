import 'package:daily_meals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  // ignore: use_key_in_widget_constructors
  const FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegetarian= widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    ValueChanged<bool?> updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
      activeColor: Colors.orange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: [
            IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save),
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust Your Meal Selection',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                      'Gluten-free',
                      'Only include gluten-free meals.',
                      _glutenFree, (newValue) {
                    setState(() {
                      _glutenFree = newValue!;
                    });
                  }),
                  _buildSwitchListTile(
                      'Lactose-free',
                      'Only include Lactose-free meals.',
                      _lactoseFree, (newValue) {
                    setState(() {
                      _lactoseFree = newValue!;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegan', 'Only include Vegan meals.', _vegan, (newValue) {
                    setState(() {
                      _vegan = newValue!;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegetarian',
                      'Only include Vegetarian meals.',
                      _vegetarian, (newValue) {
                    setState(() {
                      _vegetarian = newValue!;
                    });
                  }),
                ],
              ),
            ),
          ],
        ));
  }
}
