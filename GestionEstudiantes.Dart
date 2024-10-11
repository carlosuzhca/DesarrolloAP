import 'dart:io';

class Estudiante {
  String nombre;
  Map<String, double> calificaciones; // Clave: Asignatura, Valor: Calificación
  double promedio = 0.0;

  Estudiante(this.nombre, this.calificaciones);

  // Método para calcular el promedio de calificaciones
  void calcularPromedio() {
    double total = calificaciones.values.reduce((a, b) => a + b);
    promedio = total / calificaciones.length;
  }

  // Mostrar información del estudiante
  void mostrarInformacion() {
    print("Nombre: $nombre");
    print("Calificaciones: $calificaciones");
    print("Promedio: $promedio");
  }
}

// Función para añadir un nuevo estudiante
void agregarEstudiante(List<Estudiante> estudiantes) {
  print("Ingrese el nombre del estudiante:");
  String nombre = stdin.readLineSync()!;
  
  Map<String, double> calificaciones = {};

  while (true) {
    print("Ingrese la asignatura (o 'fin' para terminar):");
    String asignatura = stdin.readLineSync()!;
    if (asignatura.toLowerCase() == 'fin') break;

    print("Ingrese la calificación para $asignatura:");
    double calificacion = double.parse(stdin.readLineSync()!);
    calificaciones[asignatura] = calificacion;
  }

  Estudiante nuevoEstudiante = Estudiante(nombre, calificaciones);
  nuevoEstudiante.calcularPromedio();
  estudiantes.add(nuevoEstudiante);
}

// Función para mostrar estudiantes con promedio superior a un valor dado
void mostrarEstudiantesConPromedioSuperior(
    List<Estudiante> estudiantes, double valor) {
  print("Estudiantes con promedio mayor que $valor:");
  for (var estudiante in estudiantes) {
    if (estudiante.promedio > valor) {
      estudiante.mostrarInformacion();
      print('');
    }
  }
}

// Función para encontrar la calificación más alta y más baja de cada asignatura
void calificacionesAltasYBajas(List<Estudiante> estudiantes) {
  if (estudiantes.isEmpty) {
    print("No hay estudiantes.");
    return;
  }

  Map<String, List<double>> calificacionesPorAsignatura = {};

  // Recopilamos las calificaciones de cada asignatura
  for (var estudiante in estudiantes) {
    estudiante.calificaciones.forEach((asignatura, calificacion) {
      calificacionesPorAsignatura.putIfAbsent(asignatura, () => []);
      calificacionesPorAsignatura[asignatura]!.add(calificacion);
    });
  }

  // Determinar la calificación más alta y más baja por asignatura
  calificacionesPorAsignatura.forEach((asignatura, calificaciones) {
    double calificacionMax = calificaciones.reduce((a, b) => a > b ? a : b);
    double calificacionMin = calificaciones.reduce((a, b) => a < b ? a : b);

    print("Asignatura: $asignatura");
    print("Calificación más alta: $calificacionMax");
    print("Calificación más baja: $calificacionMin\n");
  });
}

// Función para ordenar los estudiantes en función de su promedio
void ordenarEstudiantesPorPromedio(
    List<Estudiante> estudiantes, bool ascendente) {
  estudiantes.sort((a, b) =>
      ascendente ? a.promedio.compareTo(b.promedio) : b.promedio.compareTo(a.promedio));

  print("Estudiantes ordenados por promedio (${ascendente ? 'Ascendente' : 'Descendente'}):");
  for (var estudiante in estudiantes) {
    estudiante.mostrarInformacion();
    print('');
  }
}

void main() {
  List<Estudiante> estudiantes = [];

  while (true) {
    print("\nSeleccione una opción:");
    print("1. Añadir un nuevo estudiante");
    print("2. Calcular y mostrar el promedio de calificaciones");
    print("3. Determinar calificaciones más altas y más bajas por asignatura");
    print("4. Mostrar estudiantes con promedio superior a un valor");
    print("5. Ordenar estudiantes por promedio");
    print("6. Salir");

    String? opcion = stdin.readLineSync();

    switch (opcion) {
      case '1':
        agregarEstudiante(estudiantes);
        break;
      case '2':
        for (var estudiante in estudiantes) {
          estudiante.mostrarInformacion();
          print('');
        }
        break;
      case '3':
        calificacionesAltasYBajas(estudiantes);
        break;
      case '4':
        print("Ingrese el valor del promedio:");
        double valor = double.parse(stdin.readLineSync()!);
        mostrarEstudiantesConPromedioSuperior(estudiantes, valor);
        break;
      case '5':
        print("¿Desea ordenar de forma ascendente? (s/n):");
        String respuesta = stdin.readLineSync()!.toLowerCase();
        bool ascendente = respuesta == 's';
        ordenarEstudiantesPorPromedio(estudiantes, ascendente);
        break;
      case '6':
        print("Saliendo del programa...");
        return;
      default:
        print("Opción no válida, intente de nuevo.");
    }
  }
}
