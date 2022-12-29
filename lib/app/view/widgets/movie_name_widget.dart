import 'package:flutter/material.dart';

class MovieNameWidget extends StatelessWidget {
  const MovieNameWidget({
    Key? key, required this.name,
  }) : super(key: key);
 final  String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Text(
       name,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 13),
        maxLines: 2,
      ),
    );
  }
}