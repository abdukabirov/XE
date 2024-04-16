import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:x_rate/api/currency_api.dart'; // Import currency API file

import 'currency_body.dart';

class Currency extends StatefulWidget {
  final VoidCallback toggleTheme;
  final ThemeData theme;

  const Currency({
    super.key,
    required this.toggleTheme,
    required this.theme,
  });

  @override
  CurrencyState createState() => CurrencyState();
}

class CurrencyState extends State<Currency> {
  List<CurrencyModel>? currencyList;
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    loadCurrency();
  }

  Future<void> loadCurrency() async {
    final List<CurrencyModel> fetchedCurrencies = await getCurrencies();
    if (mounted) {
      setState(() {
        currencyList = fetchedCurrencies;
      });
    }
  }

  Future<void> refreshData() async {
    setState(() {
      isRefreshing = true;
    });

    await loadCurrency();

    setState(() {
      isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('XE')),
      ),
      body: SafeArea(
        child: CupertinoScrollbar(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: <Widget>[
              CupertinoSliverRefreshControl(
                onRefresh: refreshData,
              ),
              currencyList == null
                  ? _buildSkeletonLoading()
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            final currency = currencyList![index];
                            return CurrencyBody(
                              currency: currency,
                            );
                          },
                          childCount: currencyList!.length,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // Define the skeleton loading function inside the CurrencyState class
  Widget _buildSkeletonLoading() {
    return SliverToBoxAdapter(
      child: Column(
        children: List.generate(
          20,
          (index) => ListTile(
            leading: Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[300]!,
              child: const CircleAvatar(
                backgroundColor: Colors.white54,
                radius: 25,
              ),
            ),
            title: Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[300]!,
              child: Container(
                height: 20,
                color: Colors.white54,
              ),
            ),
            subtitle: Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[300]!,
              child: Container(
                height: 13,
                color: Colors.white54,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
