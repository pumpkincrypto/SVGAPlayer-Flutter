import 'dart:ui' as ui show Image;
import 'package:http/http.dart';
import 'package:flutter/painting.dart';
import 'proto/svga.pb.dart';

typedef SVGACustomDrawer = Function(
    Canvas canvas, SpriteEntity sprite, int frameIndex);

class SVGADynamicEntity {
  final Map<String, bool> dynamicHidden = {};
  final Map<String, ui.Image> dynamicImages = {};
  final Map<String, TextPainter> dynamicText = {};
  final Map<String, SVGACustomDrawer> dynamicDrawer = {};

  void setHidden(bool value, String forKey) {
    dynamicHidden[forKey] = value;
  }

  void setImage(ui.Image image, String forKey) {
    dynamicImages[forKey] = image;
  }

  Future<void> setImageWithUrl(String url, String forKey) async {
    dynamicImages[forKey] =
        await decodeImageFromList((await get(Uri.parse(url))).bodyBytes);
  }

  void setText(TextPainter textPainter, String forKey) {
    if (textPainter.textDirection == null) {
      textPainter.textDirection = TextDirection.ltr;
      textPainter.layout();
    }
    dynamicText[forKey] = textPainter;
  }

  void setDynamicDrawer(SVGACustomDrawer drawer, String forKey) {
    dynamicDrawer[forKey] = drawer;
  }

  void reset() {
    dynamicHidden.clear();
    dynamicImages.clear();
    dynamicText.clear();
    dynamicDrawer.clear();
  }
}
