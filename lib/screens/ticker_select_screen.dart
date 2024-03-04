import 'package:flutter/material.dart';
import 'package:npstock/controller/detail_controller.dart';
import 'package:npstock/controller/ticker_controller.dart';
import 'package:npstock/data/response/status.dart';
import 'package:npstock/database/database_helper_repository.dart';
import 'package:npstock/styles/app_colors.dart';
import 'package:npstock/styles/app_sizes.dart';
import 'package:npstock/widgets/custom_dropdown.dart';
import 'package:npstock/widgets/general_elevated_button.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TickerSelectScreen extends StatelessWidget {
 
  TickerSelectScreen({super.key, });
  String currentName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Padding(
        padding: const EdgeInsets.only(
          top: kToolbarHeight,
        ),
        child: Consumer<TickerController>(builder: (context, provider, __) {
          switch (provider.allTicker.status) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case Status.ERROR:
              return const Center(child: Text("Error"));

            case Status.COMPLETED:
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingLg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Select Ticker",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textGrey,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomDropdown(
                          hintText: 'Select the ticker',
                          items: provider.allTicker.data!.response
                              .map((e) => e.tickerName ?? "N?A")
                              .toList(),
                          onChanged: (String newValue) {
                            currentName = newValue;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSizes.paddingLg,
                    ),
                    GeneralElevatedButton(
                      onPressed: () => onSubmit(context, provider: provider),
                      title: "Submit",
                      isMinimumWidth: true,
                      width: 160,
                      borderRadius: 8,
                      height: 45,
                    )
                  ],
                ),
              );
            default:
              return const SizedBox.shrink();
          }
        }),
      ),
    );
  }

  onSubmit(context, {required TickerController provider}) async {
    String tickerName = provider
        .allTicker
        .data!
        .response[provider.allTicker.data!.response
            .map((e) => e.tickerName ?? "N?A")
            .toList()
            .indexOf(currentName)]
        .ticker;
    if (currentName.isNotEmpty) {
      await DatabaseHelperRepository().addTicker(tickerName);
      if (context.mounted) {
        Provider.of<TickerController>(context, listen: false)
            .getUserTicker(userNotifier: true);
        Provider.of<DetailController>(context, listen: false).getAllStats();
        Navigator.pop(context);
      }
    }
  }
}
