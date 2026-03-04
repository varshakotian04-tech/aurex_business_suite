import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/resources/color_resources.dart';
import '../../core/services/auth_service.dart';
import 'orders_controller.dart';
import 'order_detail_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());
    final auth = Get.find<AuthService>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        /// Staff cannot create orders
        floatingActionButton: auth.isStaff
            ? null
            : FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  controller.createOrder();
                },
                child:
                    const Icon(Icons.add, color: Colors.black),
              ),

       body: RefreshIndicator(
  onRefresh: controller.fetchOrders,
  child: SingleChildScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Orders",
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 28),

        Obx(() {

          if (controller.isLoading.value) {
            return const Padding(
              padding: EdgeInsets.only(top: 100),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (controller.orders.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text(
                  "No orders found",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            );
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {

              final order = controller.orders[index];

              return GestureDetector(
                onTap: () {
                  Get.to(() => CreateOrderScreen(order: order));
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1D24),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order #${order.id}",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorResources.textSecondary,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Completed",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "₹${order.total.toStringAsFixed(0)}",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "${order.totalProducts} Products • ${order.totalQuantity} Items",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: ColorResources.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ],
    ),
  ),
),
      ));
  }}