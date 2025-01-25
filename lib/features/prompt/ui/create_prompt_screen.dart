import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/prompt_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  TextEditingController controller = TextEditingController();

  final PromptBloc promptBloc = PromptBloc();

  @override
  void initState() {
    promptBloc.add(PromptInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Images 🚀"),
        centerTitle: true,
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (PromptGeneratingImageLoadState):
              return Center(
                child: CircularProgressIndicator(),
              );

            case const (PromptGeneratingImageErrorState):
              return Center(
                child: Text("Something Went Wrong"),
              );

            case const (PromptGeneratingImageSuccessState):
              final sucessState = state as PromptGeneratingImageSuccessState;
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                        image: MemoryImage(
                          sucessState.uint8list,
                        ),
                        fit: BoxFit.cover,
                      )),
                    )),
                    Container(
                      height: 240,
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter your prompt",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: controller,
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.deepPurple,
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 48,
                            width: double.maxFinite,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (controller.text.isNotEmpty) {
                                  promptBloc.add(PromptEnterEvent(
                                      prompt: controller.text));
                                }
                              },
                              label: Text("Generate"),
                              icon: Icon(Icons.generating_tokens_rounded),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );

            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
