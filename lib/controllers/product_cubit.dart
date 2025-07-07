import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_state_management/models/product_model.dart';
import 'package:flutter_state_management/repos/product_repo_impl.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductLoading());
  ProductRepoImpl productRepoImpl = ProductRepoImpl();

  getProducts() async{
    try{
      final List<ProductModel> products = await productRepoImpl.getProductData();
      emit(ProductLoaded(products));
      print("Data=====================>$products");
    }catch(e){
      emit(ProductError(e.toString()));
      print("$e");
    }
  }
}
