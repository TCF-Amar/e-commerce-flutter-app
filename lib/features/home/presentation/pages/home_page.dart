import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_e_commerce/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:flutter_e_commerce/features/home/presentation/widgets/carousel_slider.dart';
import 'package:flutter_e_commerce/features/home/presentation/widgets/category_section.dart';
import 'package:flutter_e_commerce/features/home/presentation/widgets/sales_section.dart';
import 'package:flutter_e_commerce/features/home/presentation/widgets/trending_section.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/app_search_button.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    return Column(
      children: [
        AppSearchButton(),
        Expanded(
          child: ListView(
            children: [
              AppCarouselSlider(),
              const SizedBox(height: 10),
              CategorySection(),
              const SizedBox(height: 16),
              TrendingSection(),
              const SizedBox(height: 16),
              SalesSection(),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.changeTab(1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.primary,
                    foregroundColor: context.textColors.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "View All Collections",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
