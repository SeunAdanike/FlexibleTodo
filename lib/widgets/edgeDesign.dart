import 'package:flutter/material.dart';

class EdgeDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -115,
          right: -85,
          child: Container(
            width: 204,
            height: 201,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(
                color: Colors.white,
                width: 10,
              ),
              borderRadius: BorderRadius.all(Radius.elliptical(204, 201)),
            ),
          ),
        ),
        Positioned(
          top: -115,
          right: -85,
          child: Container(
            width: 164.41787719726562,
            height: 162,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border.all(
                color: Colors.white,
                width: 10,
              ),
              borderRadius:
                  BorderRadius.all(Radius.elliptical(164.41787719726562, 162)),
            ),
          ),
        ),
      ],
    );
  }
}
