import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:x_rate/api/crypto_api.dart';

import 'crypto_body.dart';

class Crypto extends StatefulWidget {
  final VoidCallback toggleTheme;
  final ThemeData theme;

  const Crypto({
    super.key,
    required this.toggleTheme,
    required this.theme,
  });

  @override
  State<Crypto> createState() => _CryptoState();
}

class _CryptoState extends State<Crypto> {
  List<CryptoModel>? cryptoList;
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    loadCrypto();
  }

  Future<void> loadCrypto() async {
    // Simulate loading delay
    await Future.delayed(const Duration(seconds: 1));

    cryptoList = await Coins().getCrypto();

    setState(() {});
  }

  Future<void> refreshData() async {
    setState(() {
      isRefreshing = true;
    });

    await loadCrypto();

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
              cryptoList == null
                  ? _buildSkeletonLoading()
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            final crypto = cryptoList![index];
                            return CryptoBody(
                              crypto: crypto,
                            );
                          },
                          childCount: cryptoList!.length,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

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
