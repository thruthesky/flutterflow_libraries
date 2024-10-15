// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewer extends StatefulWidget {
  const PhotoViewer({
    super.key,
    this.width,
    this.height,
    required this.urls,
    this.selectedIndex,
  });

  final double? width;
  final double? height;
  final List<String> urls;
  final int? selectedIndex;

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  late int currentIndex;

  /// To display immediately the photo that the user tapped
  late PageController controller = PageController(
    initialPage: currentIndex,
  );

  @override
  void initState() {
    super.initState();
    currentIndex = widget.selectedIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent],
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '${currentIndex + 1}/${widget.urls.length}',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: controller,
            itemCount: widget.urls.length,
            builder: (_, index) => PhotoViewGalleryPageOptions(
              minScale: PhotoViewComputedScale.contained,
              imageProvider: CachedNetworkImageProvider(widget.urls[index]),
              heroAttributes: PhotoViewHeroAttributes(tag: widget.urls[index]),
            ),
            onPageChanged: (index) {
              currentIndex = index;
              setState(() {});
            },
          ),
          // if the urls only gave one item don't show the arrow controls arrow
          // next and prev arrow for ux because it may confuse the user that there
          // might be another image to see
          if (widget.urls.length > 1)
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // if the current image is the first image don't show the previous
                    // arrow controll so that the user wont be confuse that there might be
                    // image to prev
                    if (currentIndex != 0) ...{
                      iconButton(
                        context,
                        onPressed: () => controller
                            .previousPage(
                                duration: const Duration(milliseconds: 150),
                                curve: Curves.linear)
                            .toString(),
                        icon: const Icon(Icons.chevron_left),
                      ),
                    } else ...{
                      const Spacer(),
                    },

                    // if the current image is already the last image don't show
                    // the next arrow control to not confuse the use that there might be
                    // more photo but when the user tap there no more
                    if (currentIndex < widget.urls.length - 1) ...{
                      iconButton(
                        context,
                        onPressed: () => controller
                            .nextPage(
                                duration: const Duration(milliseconds: 150),
                                curve: Curves.linear)
                            .toString(),
                        icon: const Icon(Icons.chevron_right),
                      ),
                    },
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  iconButton(contex, {required Icon icon, required Function() onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      style: ButtonStyle(
        iconColor: const WidgetStatePropertyAll(Colors.white),
        backgroundColor: WidgetStatePropertyAll(
          Colors.black.withAlpha(100),
        ),
      ),
    );
  }
}
