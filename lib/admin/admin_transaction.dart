import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/adminController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminTransaction extends StatefulWidget {
  const AdminTransaction({super.key});

  @override
  State<AdminTransaction> createState() => _AdminTransactionState();
}

class _AdminTransactionState extends State<AdminTransaction> {
  final AdminController adminController = Get.find<AdminController>();

  @override
  void initState() {
    super.initState();
    adminController.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transactions",
          style: TextStyle(
            fontSize: 17,
            letterSpacing: 1.5,
            color: ColorConst.titleColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => adminController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : adminController.transactions.isEmpty
                ? const Center(
                    child: Text("You have not done any transactions."),
                  )
                : SizedBox(
                    height: getH(context),
                    child: ListView.builder(
                        padding: const EdgeInsets.only(top: 8),
                        itemCount: adminController.transactions.length,
                        itemBuilder: (context, index) {
                          return TransactionCard(
                              item: adminController.transactions[index]);
                        })),
      ),
    );
  }
}
