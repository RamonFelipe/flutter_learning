import 'package:flutter/material.dart';
import './main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Map<String, bool> filters;
  final Function saveFilters;

  FiltersScreen(this.filters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  @override
  void initState() {
    super.initState();

    _isGlutenFree = widget.filters['gluten'];
    _isLactoseFree = widget.filters['lactose'];
    _isVegan = widget.filters['vegan'];
    _isVegetarian = widget.filters['vegetarian'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _isGlutenFree,
                  'lactose': _isLactoseFree,
                  'vegan': _isVegan,
                  'vegetarian': _isVegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchListTile(
                    'Gluten-Free',
                    'Only include gluten-freen meals.',
                    _isGlutenFree,
                    (newValue) {
                      setState(
                        () {
                          _isGlutenFree = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitchListTile(
                    'Lactose-Free',
                    'Only include lactose-freen meals.',
                    _isLactoseFree,
                    (newValue) {
                      setState(
                        () {
                          _isLactoseFree = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitchListTile(
                    'Vegan',
                    'Only include vegan meals.',
                    _isVegan,
                    (newValue) {
                      setState(
                        () {
                          _isVegan = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitchListTile(
                    'Vegatarian',
                    'Only include vegetarian meals.',
                    _isVegetarian,
                    (newValue) {
                      setState(
                        () {
                          _isVegetarian = newValue;
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildSwitchListTile(
      String title, String description, bool currentValue, Function update) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: update,
    );
  }
}
