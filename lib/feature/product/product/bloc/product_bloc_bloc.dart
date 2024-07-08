import 'package:bloc/bloc.dart';
import 'package:hw_pagenation/core/model/handling.dart';
import 'package:hw_pagenation/core/model/product_model.dart';
import 'package:hw_pagenation/core/service/core_service.dart';
import 'package:meta/meta.dart';

part 'product_bloc_event.dart';
part 'product_bloc_state.dart';

class ProductBlocBloc extends Bloc<ProductBlocEvent, ProductBlocState> {
  ProductBlocBloc() : super(ProductBlocInitial()) {
    on<GetProducts>((event, emit) {
      emit(LoadingMoreProducts());
      ResultModel result = ProductServiceImp().getProducts() as ResultModel;
      if (result is ListOf<ProductModel>) {
        emit(SuccessGetProducts(productModelList: result.data));
      } else {}
    });
  }
}
