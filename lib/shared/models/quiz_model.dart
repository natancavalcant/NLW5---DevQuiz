import 'dart:convert';

import 'package:DevQuiz/core/app_images.dart';
import 'package:DevQuiz/shared/models/question_model.dart';

enum Level {
  facil,
  medio,
  dificil,
  perito,
}

extension LevelStringExt on String {
  Level get levelParse => {
        "facil": Level.facil,
        "medio": Level.medio,
        "dificil": Level.dificil,
        "perito": Level.perito
      }[this]!;
}

extension AppImagesStringExt on String {
  String get imagemUrl => {
        "hierarchy": AppImages.hierarchy,
        "data": AppImages.data,
        "laptop": AppImages.laptop,
        "blocks": AppImages.blocks,
        "check": AppImages.check,
        "error": AppImages.error,
        "trophy": AppImages.trophy,
        "logo": AppImages.logo,
      }[this]!;
}

extension AppImagesNamesStringExt on String {
  String get imageName => {
        AppImages.hierarchy: "hierarchy",
        AppImages.data: "data",
        AppImages.laptop: "laptop",
        AppImages.blocks: "blocks",
        AppImages.check: "check",
        AppImages.error: "error",
        AppImages.trophy: "trophy",
        AppImages.logo: "logo",
      }[this]!;
}

extension LevelExt on Level {
  String get parse => {
        Level.facil: "facil",
        Level.medio: "medio",
        Level.dificil: "dificil",
        Level.perito: "perito"
      }[this]!;
}

class QuizModel {
  final String tittle;
  final List<QuestionModel> questions;
  final int questionsAnswered;
  final String image;
  final Level level;
  QuizModel(
      {required this.tittle,
      required this.questions,
      this.questionsAnswered = 0,
      required this.image,
      required this.level});

  Map<String, dynamic> toMap() {
    return {
      'tittle': tittle,
      'questions': questions.map((x) => x.toMap()).toList(),
      'questionsAnswered': questionsAnswered,
      'image': image.imageName,
      'level': level.parse,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      tittle: map['tittle'],
      questions: List<QuestionModel>.from(
          map['questions']?.map((x) => QuestionModel.fromMap(x))),
      questionsAnswered: map['questionsAnswered'],
      image: map['image'].toString().imagemUrl,
      level: map['level'].toString().levelParse,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source));
}
