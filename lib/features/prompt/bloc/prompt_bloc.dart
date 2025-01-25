import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_generate_ai_app/features/prompt/repos/prompt_repo.dart';
import 'package:meta/meta.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptInitialEvent>(promptInitialEvent);

    on<PromptEnterEvent>(promptEnterEvent);
  }

  FutureOr<void> promptEnterEvent(
      PromptEnterEvent event, Emitter<PromptState> emit) async {
    emit(PromptGeneratingImageLoadState());
    List<int>? bytes = await PromptRepo.generateImgae(event.prompt);
    if (bytes != null) {
      emit(PromptGeneratingImageSuccessState(Uint8List.fromList(bytes)));
    } else {
      emit(PromptGeneratingImageErrorState());
    }
  }

  FutureOr<void> promptInitialEvent(
      PromptInitialEvent event, Emitter<PromptState> emit) async {
    try {
      Uint8List bytes = await rootBundle
          .load('assets/file_bg.jpg')
          .then((data) => data.buffer.asUint8List());
      emit(PromptGeneratingImageSuccessState(bytes));
    } catch (e) {
      emit(PromptGeneratingImageErrorState());
    }
  }
}
