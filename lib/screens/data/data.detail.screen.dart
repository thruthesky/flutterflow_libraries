import 'package:flutter/material.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class DataDetailScreen extends StatefulWidget {
  static const String routeName = '/DataDetail';
  const DataDetailScreen({super.key, required this.data});

  final dynamic data;

  @override
  State<DataDetailScreen> createState() => _DataDetailScreenState();
}

class _DataDetailScreenState extends State<DataDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataDetail'),
      ),
      body: Column(
        children: [
          UserDisplayName(uid: widget.data['uid']),
          UserAvatar(uid: widget.data['uid']),
          Text('TITLE: ${widget.data['title']}'),
          Text('TITLE: ${widget.data['content']}'),
          ElevatedButton(
              onPressed: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: ReplyForm(
                            path: 'data/${widget.data['key']}',
                            data: widget.data),
                      ),
                    );
                  },
                );
              },
              child: Text('Reply')),
        ],
      ),
    );
  }
}
