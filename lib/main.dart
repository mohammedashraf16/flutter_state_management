import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_management/controllers/task_bloc.dart';
import 'package:flutter_state_management/controllers/task_event.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory:HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('===============>Build');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: BlocProvider(
          create: (context) => TaskBloc(),
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              final cubit  = context.read<TaskBloc>();
              return Column(
                children: [
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(hintText: "Enter a task"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.text.isEmpty) return;
                      cubit.add(AddTaskEvent(controller.text));
                      controller.clear();
                    },
                    child: Text("Add Task"),
                  ),
                  Expanded(
                      child: ListView.builder(
                        itemCount: state.taskList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(state.taskList[index].title),
                            leading: Checkbox(
                              value: state.taskList[index].isCompleted,
                              onChanged: (value) {
                                cubit.add(ToggleTaskEvent(state.taskList[index].id));
                              },
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  cubit.add(DeleteTaskEvent(state.taskList[index].id));
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                          );
                        },
                      ))
                ],
              );
            },
          ),
        ));
  }
}