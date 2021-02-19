import 'package:flutter/material.dart';
import 'package:flutter_book_store_sample/base/base_widget.dart';
import 'package:flutter_book_store_sample/data/remote/user_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Home',
      di: [
        Provider.value(
          value: UserService(),
        ),
      ],
      bloc: [],
      actions: [ShoppingCartWidget()],
      child: ProductListWidget(),
    );
  }
}

class ShoppingCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ProductListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
