import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class JobNewsImageList extends StatelessWidget {
  final CollectionReference _newsCollection =
      FirebaseFirestore.instance.collection('latest-job-news');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Latest Job News'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _newsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<String> imageUrls = snapshot.data!.docs
              .map((doc) => doc['imageUrl'] as String)
              .toList();

          return ListView.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => _showImagePopup(context, imageUrls[index]),
                title: CachedNetworkImage(
                  imageUrl: imageUrls[index],
                  placeholder: (context, url) => SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showImagePopup(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          child: PhotoView(
            imageProvider: CachedNetworkImageProvider(imageUrl),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      ),
    );
  }
}
