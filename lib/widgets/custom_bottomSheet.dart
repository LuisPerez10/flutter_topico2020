import 'package:flutter/material.dart';

class BottonSheetWidget extends StatelessWidget {
  const BottonSheetWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: [
            Container(
              child: Text('asda'),
            ),
          ],
        );
      },
    );
  }
}
