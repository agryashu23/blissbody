import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/detailController.dart';
import 'package:blissbody_app/controllers/ownerdetailController.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:blissbody_app/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerTransactions extends StatefulWidget {
  const OwnerTransactions({super.key});

  @override
  State<OwnerTransactions> createState() => _OwnerTransactionsState();
}

class _OwnerTransactionsState extends State<OwnerTransactions> {
  final OwnerDetailController detailController =
      Get.find<OwnerDetailController>();

  @override
  void initState() {
    super.initState();
    detailController.getOwnerTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
                          "You don't have transactions.",
                          style: TextStyle(
                            color: authController.isDarkMode.value
                                ? Colors.white
                                : ColorConst.titleColor,
                          ),
                        ),
                      )
                    : SizedBox(
                        height: getH(context),
                        child: ListView.builder(
                            padding: const EdgeInsets.only(
                                top: 8, left: 6, right: 6),
                            itemCount: detailController.transaction.length,
                            itemBuilder: (context, index) {
                              return TransactionCard(
                                  item: detailController.transaction[index],
                                  owner: true);
                            })),
          )),
    );
  }
}
