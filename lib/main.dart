import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management/bloc_observer.dart';
import 'package:flutter_state_management/controllers/product_cubit.dart';

void main() {
  runApp(const MyApp());
  Bloc.observer = AppBlocObserver();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Store App'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getProducts(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            switch (state) {
              case ProductLoading():
                return Center(child: CircularProgressIndicator());
              case ProductLoaded():
                return GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: .7,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.productList.length,
                  itemBuilder: (context, index) {
                    final product = state.productList[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(product.title),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(product.price.toString()),
                          ),
                        ],
                      ),
                    );
                  },
                );
              case ProductError():
               return Center(child: Text(state.errorMessage.toString()));
            }
          },
        ),
      ),
    );
  }
}
