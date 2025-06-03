import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/bottom_nav_constants.dart';

class AnimatedQRButton extends StatefulWidget {
  final VoidCallback onPressed;
  
  const AnimatedQRButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<AnimatedQRButton> createState() => _AnimatedQRButtonState();
}

class _AnimatedQRButtonState extends State<AnimatedQRButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
    widget.onPressed();
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: Container(
                width: BottomNavConstants.fabSize + 8,
                height: BottomNavConstants.fabSize + 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryMint.withOpacity(0.4),
                      offset: const Offset(0, 6),
                      blurRadius: 20,
                      spreadRadius: _isPressed ? 0 : 2,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Outer ring animation
                    if (_isPressed)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: BottomNavConstants.fabSize + 8,
                        height: BottomNavConstants.fabSize + 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryMint.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                      ),
                    
                    // Main button
                    Center(
                      child: Container(
                        width: BottomNavConstants.fabSize,
                        height: BottomNavConstants.fabSize,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryMint,
                              AppColors.mintSoft,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // QR icon
                            Icon(
                              Icons.qr_code_scanner_rounded,
                              color: AppColors.primaryNavy,
                              size: BottomNavConstants.fabIconSize,
                            ),
                            
                            // Scanning animation overlay
                            if (_isPressed)
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: _isPressed ? 0.3 : 0.0,
                                child: Container(
                                  width: BottomNavConstants.fabSize,
                                  height: BottomNavConstants.fabSize,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
