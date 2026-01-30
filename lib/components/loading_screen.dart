import 'package:flutter/material.dart';

class LocationLoading extends StatelessWidget {
  const LocationLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text(
              "正在取得定位資訊…",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
class LocationError extends StatelessWidget {
  final String message;

  const LocationError(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade50,
      child: Center(
        child: Text(
          "定位失敗\n$message",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
