import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),

          // Illustration
          SizedBox(
            width: 150,
            height: 150,
            child: SvgPicture.asset(
              'assests/images/Group 5363.svg',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Fallback if image is not available
                return Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person_off_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Text
          const Text(
            'No employee records found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}