import 'dart:convert';
import 'package:flutter_state_management/models/product_model.dart';
import 'package:http/http.dart'as http;
class ProductRepoImpl{
  getProductData()async{
    var url = Uri.https("fakestoreapi.com","products");
    var response = await  http.get(url);
    try{
    if(response.statusCode==200){
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json)=>ProductModel.fromMap(json)).toList();
    }else{
      throw Exception("Fail to get data");
    }
  }
    catch(e){
      throw Exception("Fail to get data");
    }
  }
}