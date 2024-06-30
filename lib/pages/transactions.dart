import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/detailController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final DetailController detailController = Get.find<DetailController>();

  @override
  void initState() {
    super.initState();
    detailController.getTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            authController.isDarkMode.value ? Colors.black : Colors.white,
        appBar: AppBar(
          title: Text(
            "TRANSACTIONS",
            style: TextStyle(
              fontSize: 17,
              letterSpacing: 1.2,
              color: authController.isDarkMode.value
                  ? Colors.white
                  : ColorConst.titleColor,
            ),
          ),
          centerTitle: true,
          backgroundColor:
              authController.isDarkMode.value ? Colors.black : Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: authController.isDarkMode.value
                  ? Colors.white
                  : ColorConst.titleColor,
            ),
          ),
        ),
        body: Obx(
          () => detailController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : detailController.transaction.isEmpty
                  ? Center(
                      child: Text(
                        "You have not done any transactions.",
                        style: TextStyle(
                          color: authController.isDarkMode.value
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: getH(context),
                      child: ListView.builder(
                          padding: const EdgeInsets.only(top: 8),
                          itemCount: detailController.transaction.length,
                          itemBuilder: (context, index) {
                            return TransactionCard(
                                item: detailController.transaction[index]);
                          })),
        ));
  }
}
