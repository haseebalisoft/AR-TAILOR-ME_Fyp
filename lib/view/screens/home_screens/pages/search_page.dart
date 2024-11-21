import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> _allItems = [
    'Shirt',
    'Pants',
    'Shoes',
    'Hat',
    'Jacket',
    'Socks',
    'Gloves',
    'Scarf'
  ];

  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    // Show all items initially
    _filteredItems = _allItems;
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = _allItems; // If query is empty, show all items
      } else {
        _filteredItems = _allItems
            .where((item) =>
                item.toLowerCase().contains(query.toLowerCase())) // Filter items
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                labelText: 'Search items',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _filteredItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_filteredItems[index]),
                        );
                      },
                    )
                  : const Center(
                      child: Text('No items found'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
