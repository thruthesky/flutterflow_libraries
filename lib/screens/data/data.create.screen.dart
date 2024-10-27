import 'package:flutter/material.dart';
import 'package:super_library/custom_code/actions/index.dart';

class DataCreateScreen extends StatefulWidget {
  static const String routeName = '/DataCreate';
  const DataCreateScreen({super.key, required this.category});

  final String category;

  @override
  State<DataCreateScreen> createState() => _DataCreateScreenState();
}

class _DataCreateScreenState extends State<DataCreateScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text('Create Post in ${widget.category}'),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
              maxLines: 5,
            ),
            ElevatedButton(
              onPressed: () async {
                print(titleController.text);
                print(contentController.text);

                await createData(
                  context,
                  widget.category,
                  titleController.text,
                  contentController.text,
                  [],
                  {},
                  (dataKey) async {
                    print('Data created with key: $dataKey');
                    Navigator.of(context).pop();
                  },
                  (e) async {
                    print('Failed to create data: $e');
                  },
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
