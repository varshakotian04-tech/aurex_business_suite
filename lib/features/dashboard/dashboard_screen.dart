import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/resources/color_resources.dart';
import 'dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return SafeArea(
      child: Obx(() {
        return Stack(
          children: [

            /// Pull To Refresh
            RefreshIndicator(
              onRefresh: controller.loadDashboard,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    /// HEADER
                    Text(
                      "Dashboard",
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Welcome back, ${controller.userRole.value}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: ColorResources.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 32),

                    /// STATS GRID
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 18,
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.15,
                      children: [

                        _statCard(
                          "Sales",
                          controller.salesCount.value.toString(),
                        ),

                        _statCard(
                          "Revenue",
                          "₹${controller.revenue.value.toStringAsFixed(0)}",
                        ),

                        _statCard(
                          "Active Users",
                          controller.activeUsers.value.toString(),
                        ),

                        _statCard(
                          "Low Stock",
                          controller.pendingTasks.value.toString(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    /// RECENT ORDERS
                    _sectionTitle("Recent Orders"),
                    const SizedBox(height: 16),

                    Builder(
                      builder: (_) {
                        final orders =
                            controller.recentOrders;

                        if (orders.isEmpty) {
                          return const Text(
                            "No recent orders",
                            style:
                                TextStyle(color: Colors.grey),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          itemCount: orders.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder:
                              (context, index) {
                            final order =
                                orders[index];

                            Color statusColor;

                            switch (order.status) {
                              case "Completed":
                                statusColor =
                                    Colors.green;
                                break;
                              case "Pending":
                                statusColor =
                                    Colors.orange;
                                break;
                              default:
                                statusColor =
                                    Colors.red;
                            }

                            return Container(
                              padding:
                                  const EdgeInsets.all(16),
                              decoration:
                                  BoxDecoration(
                                color: const Color(
                                    0xFF1A1D24),
                                borderRadius:
                                    BorderRadius
                                        .circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [

                                  /// Top Row
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                    children: [
                                      Text(
                                        "Order #${order.id}",
                                        style:
                                            const TextStyle(
                                          color:
                                              Colors.white,
                                          fontWeight:
                                              FontWeight
                                                  .w500,
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets
                                                .symmetric(
                                                    horizontal:
                                                        10,
                                                    vertical:
                                                        4),
                                        decoration:
                                            BoxDecoration(
                                          color:
                                              statusColor
                                                  .withOpacity(
                                                      0.15),
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                                      12),
                                        ),
                                        child: Text(
                                          order.status,
                                          style:
                                              TextStyle(
                                            color:
                                                statusColor,
                                            fontSize:
                                                12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                      height: 8),

                                  /// Date + Amount
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                    children: [
                                      Text(
                                        "${order.date.day}/${order.date.month}/${order.date.year}",
                                        style:
                                            const TextStyle(
                                          color:
                                              Colors.grey,
                                          fontSize:
                                              12,
                                        ),
                                      ),
                                      Text(
                                        "₹${order.total.toStringAsFixed(0)}",
                                        style:
                                            const TextStyle(
                                          color:
                                              Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    /// LOW STOCK ALERTS
                    _sectionTitle("Low Stock Alerts"),
                    const SizedBox(height: 16),

                    Builder(
                      builder: (_) {
                        final products =
                            controller
                                .lowStockProducts;

                        if (products.isEmpty) {
                          return const Text(
                            "All products are healthy",
                            style:
                                TextStyle(color: Colors.grey),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),
                          itemCount:
                              products.length,
                          separatorBuilder:
                              (_, __) =>
                                  const SizedBox(
                                      height: 12),
                          itemBuilder:
                              (context, index) {
                            final product =
                                products[index];

                            return Container(
                              padding:
                                  const EdgeInsets.all(
                                      16),
                              decoration:
                                  BoxDecoration(
                                color: const Color(
                                    0xFF1A1D24),
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.title,
                                      maxLines: 1,
                                      overflow:
                                          TextOverflow
                                              .ellipsis,
                                      style:
                                          const TextStyle(
                                        color:
                                            Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Stock: ${product.stock}",
                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            /// Loading Overlay
            if (controller.isLoading.value)
              Container(
                color: Colors.black
                    .withOpacity(0.4),
                child: const Center(
                  child:
                      CircularProgressIndicator(),
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D24),
        borderRadius:
            BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color:
                  ColorResources.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight:
                  FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}