import 'package:flutter/material.dart';

class ImageLoadingScreen extends StatefulWidget {
  @override
  _ImageLoadingScreenState createState() => _ImageLoadingScreenState();
}

class _ImageLoadingScreenState extends State<ImageLoadingScreen> {
  late Future<String> _imageLoadFuture;
  String _imageUrl =
      'https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
  @override
  void initState() {
    super.initState();
    _imageLoadFuture = Future.delayed(const Duration(seconds: 2), () {
      return _imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Loading Example'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _imageLoadFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a CircularProgressIndicator while loading
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Display an error message if loading fails
              return const Text('Error loading image');
            } else if (snapshot.hasData) {
              // Display the CircleAvatar with the loaded image
              return CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(snapshot.data!),
              );
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
    );
  }
}
