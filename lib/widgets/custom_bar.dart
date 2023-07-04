import 'package:flutter/material.dart';

class CustomBar extends StatelessWidget {
  const CustomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          const Spacer(),
          const CircleAvatar(
            backgroundImage: AssetImage('images/apples.jpeg'),
          ),
        ],
      ),
    );
  }
}