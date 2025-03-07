import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: ImageGallery())),
    );
  }
}

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  ImageGalleryState createState() => ImageGalleryState();
}

class ImageGalleryState extends State<ImageGallery> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Map<String, String>> _imageData = [
    {
      'image': 'assets/images/bukber.jpg',
      'title': 'Buka Bersama',
      'description': 'Buka Bersama teman kelas di rumah Lukman',
    },
    {
      'image': 'assets/images/nugas.jpg',
      'title': 'Nugas',
      'description': 'Mengerjakan tugas pemrograman mobile dari pak Pizaini',
    },
    {
      'image': 'assets/images/shalat.jpg',
      'title': 'Shalat Jumat',
      'description': 'Melaksanakan ibadah shalat jumat di masjid',
    },
    {
      'image': 'assets/images/simatif.jpg',
      'title': 'SIMATIF',
      'description': 'Senam pagi bersama teman-teman SIMATIF',
    },
    {
      'image': 'assets/images/bakar_bakar.jpg',
      'title': 'Bakar-bakar',
      'description': 'Bakar-bakar di bersama teman-teman di rumah Lukman',
    },
  ];

  void _nextImage() {
    if (_currentIndex < _imageData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isPortrait)
              SizedBox(
                height: 60,
              ), // Add space at the top only in portrait mode
            Expanded(child: _buildImageContainer()),
            SizedBox(height: 20),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 120),
              child: _buildDescriptionContainer(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavigationButtons(),
    );
  }

  Widget _buildImageContainer() {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(10.0),
      decoration: _boxDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: PageView.builder(
          controller: _pageController,
          itemCount: _imageData.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Image.asset(_imageData[index]['image']!, fit: BoxFit.cover);
          },
        ),
      ),
    );
  }

  Widget _buildDescriptionContainer() {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(8.0),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _imageData[_currentIndex]['title']!,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            _imageData[_currentIndex]['description']!,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return BottomAppBar(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 30,
            color: Colors.black,
            onPressed: _previousImage,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            iconSize: 30,
            color: Colors.black,
            onPressed: _nextImage,
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(2, 5)),
      ],
    );
  }
}
