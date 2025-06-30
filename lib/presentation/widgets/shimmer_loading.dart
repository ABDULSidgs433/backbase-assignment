import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10, // Number of shimmer items
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book cover placeholder
                Container(
                  width: 60,
                  height: 80,
                  color: Colors.white,
                  margin: const EdgeInsets.only(right: 16),
                ),
                // Text content placeholder
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title placeholder
                      Container(
                        width: double.infinity,
                        height: 16,
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 8),
                      ),
                      // Author placeholder
                      Container(
                        width: 150,
                        height: 14,
                        color: Colors.white,
                      ),
                      // Spacer
                      const SizedBox(height: 16),
                      // Description line 1
                      Container(
                        width: double.infinity,
                        height: 12,
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 4),
                      ),
                      // Description line 2
                      Container(
                        width: double.infinity,
                        height: 12,
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 4),
                      ),
                      // Description line 3 (shorter)
                      Container(
                        width: 200,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}