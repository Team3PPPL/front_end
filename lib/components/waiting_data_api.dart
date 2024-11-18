import 'package:flutter/material.dart';

Future<void> showLoadingDialog(context) async {
  return showDialog(
    context: context,
    barrierDismissible:
        false, // Pengguna tidak bisa menutup dialog dengan mengetuk di luar
    builder: (BuildContext context) {
      return const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Uploading...'),
          ],
        ),
      );
    },
  );
}
