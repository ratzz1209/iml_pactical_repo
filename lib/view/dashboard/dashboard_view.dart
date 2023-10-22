import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical_test_iml/utils/common_colors.dart';
import 'package:practical_test_iml/view/dashboard/dashbaord_view_model.dart';
import 'package:provider/provider.dart';
import '../dashboard_detail/dashboard_detail_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late DashboardViewModel mViewModel;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      mViewModel.getDashboardData();
    });
    super.initState();
  }

  @override
  void dispose() {
    mViewModel.countryInfoList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<DashboardViewModel>(context);

    return Scaffold(
      backgroundColor: CommonColors.primaryLite,
      appBar: AppBar(
        backgroundColor: CommonColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Country Info",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: CommonColors.mWhite,
          ),
        ),
      ),
      body: mViewModel.isApiLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: CommonColors.primaryColor,
              strokeWidth: 1,
            ))
          : mViewModel.countryInfoList.isEmpty
              ? const Center(
                  child: Text(
                    "Country data is not available",
                    maxLines: 2,
                    style: TextStyle(
                      color: CommonColors.blackColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  itemBuilder: (context, index) => InkWell(
                    splashColor: CommonColors.primaryColor.withOpacity(.1),
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                        return DashboardDetailView(
                          mapData: mViewModel.countryInfoList[index],
                        );
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: CommonColors.mWhite,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: .1,
                              blurRadius: .1,
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Text(
                                    mViewModel.countryInfoList[index]["name"],
                                    maxLines: 2,
                                    style: const TextStyle(
                                      color: CommonColors.blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${mViewModel.countryInfoList[index]["city"]},${mViewModel.countryInfoList[index]["state"]}",
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: CommonColors.mGrey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Text(
                                    mViewModel.countryInfoList[index]["icao"],
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: CommonColors.blackColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  mViewModel.countryInfoList[index]["country"],
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: CommonColors.mGrey,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                    width: 10,
                  ),
                  itemCount: mViewModel.countryInfoList.length,
                ),
    );
  }
}
