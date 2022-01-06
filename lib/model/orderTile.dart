import 'package:flutter/material.dart';

class OrderTile extends StatefulWidget {
  String number;
  String time;

  OrderTile({
    required this.number,
    required this.time,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _OrderTileState createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(spreadRadius: 4, color: Color.fromARGB(4, 0, 0, 0))
              ]),
          height: 116,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 56, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Заказ №${widget.number}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
              const Divider(
                // height: 2,
                thickness: 1.5,
                color: Color(0xff69A8BB),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(265, 16, 16, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.time,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
