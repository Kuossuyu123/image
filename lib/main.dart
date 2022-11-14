import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final ValueNotifier<int>_imageIndex = ValueNotifier(0); //list
  static const _images = <String>['assets/image1.png', 'assets/image5.jpg',
    'assets/image3.jpg', 'assets/image4.jpg'];

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('映像瀏覽'),
    );

    final previousBtn = IconButton(
      icon: const Icon(Icons.arrow_circle_left_rounded),
      iconSize: 40,
      onPressed: () => _previousImage(),
    );

    final nextBtn = IconButton(
      icon: const Icon(Icons.arrow_circle_right_rounded),
      //Image.asset('assets/image2.jpg'),
      iconSize: 40,
      onPressed: () => _nextImage(),
    );

    final widget = Center(
      child: Stack( //Column
        children: <Widget>[
          Container(
            child: ValueListenableBuilder<int>(
              builder: _imageBuilder,
              valueListenable: _imageIndex,

            ),
            margin: const EdgeInsets.symmetric(vertical: 10),

          ),
          Container(
            child: Row(
            children: <Widget>[previousBtn, nextBtn],
              mainAxisAlignment: MainAxisAlignment.center,

            ),
            margin: const EdgeInsets.symmetric(vertical: 10),

          ),
        ],
        alignment: Alignment.topCenter,//mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    final appHomePage = Scaffold(
      appBar: appBar,
      body: widget,
    );
    return appHomePage;
  }


  Widget _imageBuilder(BuildContext context,int imageIndex,Widget?child){
    //Image img =Image.asset(_images[imageIndex]);
    //return img;
    var img =PhotoView(
        imageProvider: AssetImage(_images[_imageIndex.value]),
      minScale: PhotoViewComputedScale.contained*0.6,
      maxScale: PhotoViewComputedScale.covered,
      enableRotation: true,
      backgroundDecoration: const BoxDecoration(
        color: Colors.white,
      )
    );
    return img;
  }


  _previousImage(){
    _imageIndex.value=
        _imageIndex.value==0?_images.length-1:_imageIndex.value-1;
  }
  _nextImage(){
    _imageIndex.value= ++_imageIndex.value %_images.length;
  }
}


