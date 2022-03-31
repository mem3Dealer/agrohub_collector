import 'dart:developer';

import 'package:flutter/material.dart';
// part 'productCard.dart';

class ImagePlacer extends StatefulWidget {
  String url;
  ImagePlacer({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<ImagePlacer> createState() => _ImagePlacerState();
}

class _ImagePlacerState extends State<ImagePlacer> {
  @override
  Widget build(BuildContext context) {
    double _wdt = MediaQuery.of(context).size.width;
    double _picW;
    if (_wdt > 350) {
      _picW = 132;
    } else {
      _picW = 100;
    }
//однажды я это решу :)
// проблема была в том, что он выкидывал ошибку битой ссылки (badUrl) в моменты когда я нажимал на кнопку
// чтобы перейти на экран инфы. В общем - так работает.
    String badUrl = 'https://storage.yandexcloud.net/goods-images/media/';
    String _ph =
        'https://www.fwhealth.org/wp-content/uploads/2017/03/placeholder-500x500.jpg';
    Image image = Image.network(
      widget.url == badUrl ? _ph : widget.url,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            color: const Color(0xffE14D43),
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        inspect(error);
        return Image.asset('assets/images/placeholder.jpg');
      },
    );
    return Container(width: _picW, height: _picW, child: image);
  }
}
