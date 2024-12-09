import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteStreamDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteStreamDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipPath(
        clipper: VerticesClipper(),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 320),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(1),
                blurRadius: 10,
                spreadRadius: 10,
                offset: const Offset(0, 0),
              ),
            ],
            gradient: const RadialGradient(
              // begin: Alignment.topCenter,
              // end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0C1113),
                Color(0xFF0C1113),
                //  Color(0xFF42555A),
                //  Color(0xFF050809)
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Custom header with angled background
              Row(
                children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 3,
                    child: Row(
                      // fit: StackFit.expand,
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipPath(
                          clipper: ButtonClipper(),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40),
                            height: 40,
                            decoration: const BoxDecoration(
                              // gradient: LinearGradient(
                              //   begin: Alignment.topLeft,
                              //   end: Alignment.bottomRight,
                              //   colors: [
                              //     const Color(0xFFDC1A22),
                              //     const Color(0xFFDC1A22).withOpacity(0.8),
                              //   ],
                              // ),
                              color: Colors.red,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Delete Stream',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    
                        // Close button
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Delete\nicon\nLottiefiles',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Are you sure to delete the stream ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Confirm button
                    _buildButton(
                      text: 'Confirm',
                      onPressed: onConfirm,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VerticesClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Starting point (bottom-left corner)
    path.moveTo(10, size.height);

    // Left side with a diagonal cut
    path.lineTo(0, size.height - 10);

    // Top-left corner
    path.lineTo(0, 10);
    path.lineTo(10, 0);

    // Top edge with a diagonal cut at the top-right corner
    path.lineTo(size.width - 10, 0);
    path.lineTo(size.width, 10);

    // Right edge with a diagonal cut at the bottom-right corner
    path.lineTo(size.width, size.height - 10);
    path.lineTo(size.width - 10, size.height);

    // Bottom edge back to the starting point
    path.lineTo(10, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);

    path.lineTo(20, size.height);

    path.lineTo(size.width - 20, size.height);
    path.lineTo(size.width, 0);

    path.lineTo(0, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


Widget _buildButton({
  required String text,
  required VoidCallback onPressed,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 1,
      ),
    ),
    child: SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  );
}
