import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final VoidCallback onSortTap;
  final VoidCallback onFilterTap;
  final bool? showFilter;

  const FilterBar({
    super.key,
    required this.onSortTap,
    required this.onFilterTap,
    this.showFilter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          showFilter == true
              ? InkWell(
                  onTap: onFilterTap,
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: const [
                      Icon(Icons.filter_alt_rounded, size: 20),
                      SizedBox(width: 6),
                      Text(
                        "Filter",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          const Spacer(),
          InkWell(
            onTap: onSortTap,
            borderRadius: BorderRadius.circular(8),
            child: Row(
              children: const [
                Icon(Icons.sort_rounded, size: 20),
                SizedBox(width: 6),
                Text(
                  "Sort",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
