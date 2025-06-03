import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/bottom_nav_constants.dart';

class DraggableBottomNav extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final VoidCallback onQRCodePressed;
  final List<Widget> moduleItems;
  final Widget? customQRButton;

  const DraggableBottomNav({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onQRCodePressed,
    required this.moduleItems,
    this.customQRButton,
  }) : super(key: key);

  @override
  State<DraggableBottomNav> createState() => _DraggableBottomNavState();
}

class _DraggableBottomNavState extends State<DraggableBottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  late Animation<double> _dragIndicatorAnimation;
  late Animation<double> _contentOpacityAnimation;
  
  bool _isExpanded = false;
  double _dragOffset = 0.0;
  double _currentHeight = BottomNavConstants.collapsedHeight;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: BottomNavConstants.animationDuration,
      vsync: this,
    );
    
    _heightAnimation = Tween<double>(
      begin: BottomNavConstants.collapsedHeight,
      end: BottomNavConstants.expandedHeight,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    ));
    
    _dragIndicatorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _contentOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    ));
    
    _heightAnimation.addListener(() {
      setState(() {
        _currentHeight = _heightAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset -= details.delta.dy;
      _dragOffset = _dragOffset.clamp(0.0, BottomNavConstants.expandedHeight - BottomNavConstants.collapsedHeight);
      
      final progress = _dragOffset / (BottomNavConstants.expandedHeight - BottomNavConstants.collapsedHeight);
      _currentHeight = BottomNavConstants.collapsedHeight + _dragOffset;
      _animationController.value = progress;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0.0;
    final progress = _dragOffset / (BottomNavConstants.expandedHeight - BottomNavConstants.collapsedHeight);
    
    if (velocity < -500 || (velocity >= -500 && progress > 0.5)) {
      _animationController.forward();
      setState(() {
        _isExpanded = true;
      });
    } else {
      _animationController.reverse();
      setState(() {
        _isExpanded = false;
      });
    }
    
    setState(() {
      _dragOffset = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          height: _currentHeight,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(BottomNavConstants.borderRadius),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryNavy.withOpacity(0.1),
                offset: const Offset(0, -4),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag Handle
              GestureDetector(
                onVerticalDragUpdate: _handleDragUpdate,
                onVerticalDragEnd: _handleDragEnd,
                onTap: _toggleExpanded,
                child: Container(
                  height: 30,
                  color: Colors.transparent,
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.darkGray.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Navigation Items
              Container(
                height: BottomNavConstants.collapsedHeight - 30,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Regular navigation items
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNavItem(
                          icon: DefaultBottomNavItems.items[0].icon,
                          label: DefaultBottomNavItems.items[0].label,
                          index: 0,
                        ),
                        const SizedBox(width: BottomNavConstants.fabSize + 20), // Space for QR button
                        _buildNavItem(
                          icon: DefaultBottomNavItems.items[1].icon,
                          label: DefaultBottomNavItems.items[1].label,
                          index: 1,
                        ),
                        _buildNavItem(
                          icon: DefaultBottomNavItems.items[2].icon,
                          label: DefaultBottomNavItems.items[2].label,
                          index: 2,
                        ),
                      ],
                    ),
                    
                    // QR Code button (center)
                    Positioned(
                      bottom: 15,
                      child: widget.customQRButton ?? _buildQRButton(),
                    ),
                  ],
                ),
              ),
              
              // Expanded Content
              if (_heightAnimation.value > BottomNavConstants.collapsedHeight)
                Expanded(
                  child: FadeTransition(
                    opacity: _contentOpacityAnimation,
                    child: _buildExpandedContent(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = widget.selectedIndex == index;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onItemSelected(index),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 16 : 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryMint.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primaryNavy : AppColors.darkGray,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: isSelected ? AppColors.primaryNavy : AppColors.darkGray,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQRButton() {
    return GestureDetector(
      onTap: widget.onQRCodePressed,
      child: Container(
        width: BottomNavConstants.fabSize,
        height: BottomNavConstants.fabSize,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryMint, AppColors.mintSoft],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(BottomNavConstants.fabSize / 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryMint.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: const Icon(
          Icons.qr_code_scanner_rounded,
          color: AppColors.primaryNavy,
          size: BottomNavConstants.fabIconSize,
        ),
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Access Modules',
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: BottomNavConstants.moduleGridSpacing,
              mainAxisSpacing: BottomNavConstants.moduleGridSpacing,
              children: widget.moduleItems,
            ),
          ),
        ],
      ),
    );
  }
}
