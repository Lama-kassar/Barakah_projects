import 'package:dio/dio.dart';
import 'package:hw_pagenation/core/model/handling.dart';
import 'package:hw_pagenation/core/model/product_model.dart';

abstract class CoreService {
  Dio dio = Dio();
  late Response response;
}

abstract class ProductService extends CoreService {
  String baseurl = "https://freetestapi.com/api/v1/products";
  Future<ResultModel> getProducts();
}

class ProductServiceImp extends ProductService {
  //ProductModel? productModel = null;
  @override
  Future<ResultModel> getProducts() async {
    try {
      response = await dio.get(baseurl);
      if (response.statusCode == 200) {
        List<ProductModel> products = List.generate(
          response.data.length,
          (index) => ProductModel.fromMap(response.data[index]),
        );
        return ListOf<ProductModel>(data: products);
      } else {
        return ErrorModel(message: 'The Status code is not 200');
      }
    } on DioException catch (e) {
      return ExceptionModel(message: e.error.toString());
    }
  }
}


class SuccessGetProducts extends productState {
  final ProductModel productModel;
  SuccessGetProducts({
    required this.productModel,
  });
}

class ErrorToGetProoducts extends productState {}

class LoadingToGetProducts extends productState {}

class LoadingMoreProducts extends productState {}


class ErrorEvent extends productEvent {
  final String error;

  ErrorEvent(this.error);
}

class GetProducts extends productEvent {}

class LoadingMore extends productEvent {}