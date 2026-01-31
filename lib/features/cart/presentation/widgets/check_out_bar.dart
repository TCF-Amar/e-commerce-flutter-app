import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/core/theme/theme_extensions.dart';
import 'package:flutter_e_commerce/features/cart/presentation/controller/cart_controller.dart';
import 'package:flutter_e_commerce/features/zShared/widgets/index.dart';
import 'package:get/get.dart';

class CheckOutBar extends GetView<CartController> {
  const CheckOutBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -5),
            blurRadius: 20,
          ),
        ],
      ),
      child: Obx(() {
        return Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: controller.isAllSelected,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onChanged: (_) => controller.toggleAllSelection(),
                ),
                const AppText("All", fontSize: 16, fontWeight: FontWeight.bold),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppText(
                      "Shipping: \$24.00",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        const AppText(
                          "Total: ",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        AppText(
                          "${controller.subTotal}",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            AppButton(
              child: AppText("Checkout", fontSize: 16, color: Colors.white),
              onPressed: () {},
            ),
          ],
        );
      }),
    );
  }
}
