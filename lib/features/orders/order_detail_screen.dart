import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/order_model.dart';

class CreateOrderScreen extends StatelessWidget {
  final OrderModel order;

  const CreateOrderScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1117),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Order Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Order #${order.id}",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              order.date.toString(),
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),

            Text(
              "Products",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {

                final product = order.products[index];

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1D24),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Expanded(
                        child: Text(
                          product.title,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),

                      Text(
                        "${product.quantity} x ₹${product.price}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            Text(
              "Total: ₹${order.total.toStringAsFixed(0)}",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}