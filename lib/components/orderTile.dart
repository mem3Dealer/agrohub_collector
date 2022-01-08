import 'package:agrohub_collector_flutter/bloc/business_logic_layer/collecting_lists_bloc.dart';
import 'package:agrohub_collector_flutter/pages/collectingOrderPage.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  // double _height = 116;
  // bool isVisiible = true;

  @override
  Widget build(
    BuildContext context,
  ) {
    return buildOrderTile(widget.number, widget.time);
  }

  Widget buildOrderTile(String number, String time) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Card(
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            hasIcon: false,
          ),
          header: Column(
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
                padding: const EdgeInsets.fromLTRB(265, 12, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
              ),
            ],
          ),
          collapsed: Container(),
          expanded: Center(
            child: SizedBox(
                height: 72,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    width: 350,
                    height: 56,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          // padding:
                          //     MaterialStateProperty.all(EdgeInsets.all(16)),
                          backgroundColor: MaterialStateProperty.all(
                        const Color(0xff69A8BB),
                      )),
                      onPressed: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                CollectingOrderPage(number: number, time: time),
                          ),
                        );
                      },
                      child: const Text(
                        'Начать сборку',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

//   void expandTile() {
//     setState(() {
//       isVisiible = !isVisiible;
//     });
//   }
// }

// class First extends StatelessWidget {
//   const First({
//     Key? key,
//     required this.widget,
//     required this.isVisiible,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//             padding: const EdgeInsets.fromLTRB(16, 12, 56, 12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   "Заказ №${widget.number}",
//                   textAlign: TextAlign.left,
//                   style: const TextStyle(
//                       fontFamily: 'Roboto',
//                       fontSize: 24,
//                       fontWeight: FontWeight.w500),
//                 ),
//               ],
//             )),
//         const Divider(
//           // height: 2,
//           thickness: 1.5,
//           color: Color(0xff69A8BB),
//         ),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(265, 16, 16, 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Text(
//                 widget.time,
//                 textAlign: TextAlign.end,
//                 style: const TextStyle(
//                     fontFamily: 'Roboto',
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//         ),
//         isVisiible
//             ? SizedBox(
//                 height: 72,
//                 child: Container(
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(4)),
//                   width: 350,
//                   height: 56,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                           // padding:
//                           //     MaterialStateProperty.all(EdgeInsets.all(16)),
//                           backgroundColor: MaterialStateProperty.all(
//                         const Color(0xff69A8BB),
//                       )),
//                       onPressed: () {
//                         print('pressed');
//                       },
//                       child: const Text(
//                         'Начать сборку',
//                         style: TextStyle(
//                             fontFamily: 'Roboto',
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ))
//             : Container()
//       ],
//     );
//   }
}
