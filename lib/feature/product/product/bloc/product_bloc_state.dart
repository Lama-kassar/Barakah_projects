part of 'product_bloc_bloc.dart';

@immutable
sealed class ProductBlocState {}

final class ProductBlocInitial extends ProductBlocState {}

class SuccessGetProducts extends ProductBlocState {
  final ListOf<ProductModel> productModelList;
  SuccessGetProducts({
    required this.productModelList,
  });
}

class ErrorToGetProoducts extends ProductBlocState {}

class LoadingToGetProducts extends ProductBlocState {}

class LoadingMoreProducts extends ProductBlocState {}
