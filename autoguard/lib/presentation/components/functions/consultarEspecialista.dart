import 'dart:math';

import 'package:autoguard/presentation/entities/DataEntities/EspecialidadMedica.dart';
import 'package:autoguard/presentation/providers/turnoProvider.dart';
import 'package:dart_openai/dart_openai.dart';

Future<void> consultarEspecialista (String inputUsuario, List<EspecialidadMedica> especialidadesDisponibles, turnoNotifier turnoNotifier) async {
  final especialidadesList = especialidadesDisponibles.map((e) => e.nombre).toList();
  String especialidades = especialidadesList.join(',');
  
  String presentacion = "Es muy importante que respondas con una sola palabra y solo usando las especialidades que se listan a continuación. Eres la recepcionista de una Clínica u Hospital. La institución cuenta únicamente con especialistas en las siguientes especialidades médicas: ";
  //String especialidades = "Clínico, Traumatólogo, Cardiólogo, Dentista, Dermatólogo.";
  String paciente = " Razón del paciente para buscar consulta médica: ";
  String fin = "Solo puedes responder con el nombre de la especialidad que se especifica en este prompt. Si la respuesta no se encuentra en este prompt, responde: Especialidad no disponible.";
  String prompt = presentacion + especialidades + paciente + inputUsuario + fin;

  OpenAICompletionModel completion = await OpenAI.instance.completion.create(
    model: 'gpt-3.5-turbo-instruct',
    prompt: prompt,
    maxTokens: 20
  );

  print(completion.choices.first.text); // ...

  String especialidadSeleccionada;

  var close = getCloseMatches(completion.choices.first.text.trim(), especialidadesList, cutoff: 0.7);

  if (close.isNotEmpty) {
    especialidadSeleccionada = close.first;
  } else {
    especialidadSeleccionada = "Clinico";
  }


  turnoNotifier.setInputRazonConsulta(inputUsuario);
  turnoNotifier.setEspecialidadSeleccionada(especialidadSeleccionada);
}

int levenshtein(String s, String t) {
  if (s == t) return 0;
  if (s.isEmpty) return t.length;
  if (t.isEmpty) return s.length;

  List<int> v0 = List.filled(t.length + 1, 0);
  List<int> v1 = List.filled(t.length + 1, 0);

  for (int i = 0; i < v0.length; i++) v0[i] = i;

  for (int i = 0; i < s.length; i++) {
    v1[0] = i + 1;

    for (int j = 0; j < t.length; j++) {
      int cost = (s[i] == t[j]) ? 0 : 1;
      v1[j + 1] = [
        v1[j] + 1,
        v0[j + 1] + 1,
        v0[j] + cost,
      ].reduce(min);
    }

    for (int j = 0; j < v0.length; j++) v0[j] = v1[j];
  }

  return v1[t.length];
}

List<String> getCloseMatches(String word, List<String> possibilities, {double cutoff = 0.6}) {
  Map<String, int> distances = {};
  int wordLength = word.length;

  for (String option in possibilities) {
    int distance = levenshtein(word, option);
    double similarity = 1 - (distance / max(wordLength, option.length));
    if (similarity >= cutoff) {
      distances[option] = distance;
    }
  }

  var sortedMatches = distances.keys.toList()
    ..sort((a, b) => distances[a]!.compareTo(distances[b]!));

  return sortedMatches;
}