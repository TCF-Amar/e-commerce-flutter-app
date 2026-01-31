import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/routes/app_routes.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:go_router/go_router.dart';

class AppSearchButton extends StatefulWidget {
  final bool full;

  const AppSearchButton({super.key, this.full = true});

  @override
  State<AppSearchButton> createState() => _AppSearchButtonState();
}

class _AppSearchButtonState extends State<AppSearchButton>
    with SingleTickerProviderStateMixin {
  final List<String> texts = [
    "Search",
    "Search your favorite",
    "Explore new fashion",
    "Find your style",
  ];

  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start the loop
    _startAnimationLoop();
  }

  void _startAnimationLoop() async {
    if (!mounted) return;
    _controller.forward();

    while (mounted) {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) break;
      await _controller.reverse();
      if (!mounted) break;
      setState(() {
        _currentIndex = (_currentIndex + 1) % texts.length;
      });
      await _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.colorScheme;

    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.search.path);
      },
      child: widget.full
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.background,
                borderRadius: BorderRadius.circular(
                  10,
                ), // More rounded for modern look
                border: Border.all(
                  color: theme.foreground.withValues(alpha: 0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    // color: theme.surface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: AppText(
                          texts[_currentIndex],
                          fontSize: 15,
                          // color: theme.surface.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // color: theme.background,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.search_rounded),
            ),
    );
  }
}
