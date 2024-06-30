import 'dart:typed_data';

class ImageItem {
  final String imageUrl;
  final Uint8List? imageData;
  final bool isNetworkImage;

  ImageItem({
    required this.imageUrl,
    this.imageData,
    this.isNetworkImage = true,
  });
}
