import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class DataListTile extends StatefulWidget {
  const DataListTile({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  State<DataListTile> createState() => _DataListTileState();
}

class _DataListTileState extends State<DataListTile> {
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 12,
        left: 24,
        right: 24,
        bottom: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              UserAvatar(uid: widget.data['uid']),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserDisplayName(uid: widget.data['uid']),
                  Text(
                    widget.data['title'] ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            widget.data.toString(),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text('Like'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Reply'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Chat'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Block'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Report'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
