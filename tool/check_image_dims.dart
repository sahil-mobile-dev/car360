import 'dart:io';
import 'dart:typed_data';

void main() async {
  final file = File('assets/images/car1.png');
  if (!await file.exists()) {
    print('File not found');
    return;
  }

  final bytes = await file.readAsBytes();
  // Check PNG signature
  if (bytes[0] != 0x89 ||
      bytes[1] != 0x50 ||
      bytes[2] != 0x4E ||
      bytes[3] != 0x47) {
    print('Not a PNG');
    return;
  }

  // IHDR chunk starts after 8 byte signature.
  // Length (4), Chunk Type (4), Width (4), Height (4)
  // IHDR data starts at byte 16. Width at 16, Height at 20.
  final width = _readInt(bytes, 16);
  final height = _readInt(bytes, 20);

  print('Width: $width');
  print('Height: $height');
  print('Aspect Ratio: ${width / height}');
}

int _readInt(Uint8List bytes, int offset) {
  return (bytes[offset] << 24) |
      (bytes[offset + 1] << 16) |
      (bytes[offset + 2] << 8) |
      bytes[offset + 3];
}
