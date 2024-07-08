import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hw_pagenation/feature/product/product/bloc/product_bloc_bloc.dart';

class productPage extends StatelessWidget {
  productPage({super.key});
  final sc = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBlocBloc(),
      child: Scaffold(
        body: BlocConsumer<ProductBlocBloc, ProductBlocState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is SuccessGetProducts) {
              return ListView.builder(
                  itemCount: state.productModelList.data,
                  controller: sc,
                  itemBuilder: (context, index) => ListTile(
                        leading: state.productModelList.data,
                        title: state.productModelList.data[''],
                        subtitle: state.productModelList.data[''],
                        trailing: state.productModelList.data[''],
                      ));
            } else if (state is ErrorToGetProoducts) {
              return Text("errore data");
            }
          },
        ),
        floatingActionButton: FloatingActionButton.small(onPressed: () {
          context.read<ProductBlocBloc>().add(GetProducts());
        }),
      ),
    );
  }
}
