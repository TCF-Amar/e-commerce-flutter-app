import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/loading/skeleton_container.dart';

class ProductListSkeleton extends StatelessWidget {
  final Axis scrollDirection;
  final int itemCount;

  const ProductListSkeleton({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.itemCount = 6,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: scrollDirection,
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(
        width: scrollDirection == Axis.horizontal ? 16 : 0,
        height: scrollDirection == Axis.vertical ? 16 : 0,
      ),
      itemBuilder: (context, index) {
        if (scrollDirection == Axis.horizontal) {
          return const _ProductCardSkeletonHorizontal();
        }
        return const _ProductCardSkeletonVertical();
      },
    );
  }
}

class _ProductCardSkeletonVertical extends StatelessWidget {
  const _ProductCardSkeletonVertical();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120, // Height for the list tile style card
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          // Image placeholder
          SkeletonContainer(
            width: 120,
            height: 120,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
          ),
          // Details placeholder
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SkeletonContainer(width: 150, height: 14),
                  const SkeletonContainer(width: 100, height: 14),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SkeletonContainer(width: 80, height: 18),
                      SkeletonContainer(width: 40, height: 14),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCardSkeletonHorizontal extends StatelessWidget {
  const _ProductCardSkeletonHorizontal();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160, // Width for the horizontal card
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Expanded(
            flex: 3,
            child: SkeletonContainer(
              width: double.infinity,
              height: double.infinity,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
          ),
          // Details placeholder
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SkeletonContainer(width: double.infinity, height: 10),
                  const SizedBox(height: 4),
                  const SkeletonContainer(width: 80, height: 10),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SkeletonContainer(width: 50, height: 12),
                      SkeletonContainer(width: 30, height: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
