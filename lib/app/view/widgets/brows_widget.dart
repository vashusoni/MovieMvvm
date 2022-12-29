import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BrowsWidget extends StatelessWidget {
  const BrowsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Browser",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30),
            ),
            Icon(
              CupertinoIcons.line_horizontal_3_decrease,
              color: Colors.white,
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "Movie",
          style: TextStyle(
              fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }
}