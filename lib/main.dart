import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Verificador de Billetes',

      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF0D47A1),
        scaffoldBackgroundColor: Color(0xFFF5F7FA),

        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
          elevation: 2,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1565C0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),

      home: VerificadorPage(),
    );
  }
}

class VerificadorPage extends StatefulWidget {
  @override
  _VerificadorPageState createState() => _VerificadorPageState();
}

class _VerificadorPageState extends State<VerificadorPage> {
  String corte = "10";
  TextEditingController serieController = TextEditingController();

  String resultado = "";
  bool? esValido;

  bool verificarSerie(String serie) {
    int numero = int.parse(serie);

    if (corte == "10") {
      if ((numero >= 77100001 && numero <= 77550000) ||
          (numero >= 78000001 && numero <= 78450000) ||
          (numero >= 78900001 && numero <= 96350000) ||
          (numero >= 96350001 && numero <= 96800000) ||
          (numero >= 96800001 && numero <= 97250000) ||
          (numero >= 98150001 && numero <= 98600000) ||
          (numero >= 104900001 && numero <= 105350000) ||
          (numero >= 105350001 && numero <= 105800000) ||
          (numero >= 106700001 && numero <= 107150000) ||
          (numero >= 107600001 && numero <= 108050000) ||
          (numero >= 108050001 && numero <= 108500000) ||
          (numero >= 109400001 && numero <= 109850000)) {
        return false;
      }
    }

    if (corte == "20") {
      if ((numero >= 87280145 && numero <= 91646549) ||
          (numero >= 96650001 && numero <= 97100000) ||
          (numero >= 99800001 && numero <= 100250000) ||
          (numero >= 100250001 && numero <= 100700000) ||
          (numero >= 109250001 && numero <= 109700000) ||
          (numero >= 110600001 && numero <= 111050000) ||
          (numero >= 111050001 && numero <= 112400000) ||
          (numero >= 112400001 && numero <= 113300000) ||
          (numero >= 112850001 && numero <= 114650000) ||
          (numero >= 114650001 && numero <= 115100000) ||
          (numero >= 115100001 && numero <= 115550000) ||
          (numero >= 118700001 && numero <= 119150000) ||
          (numero >= 119150001 && numero <= 119600000) ||
          (numero >= 120500001 && numero <= 120950000)) {
        return false;
      }
    }

    if (corte == "50") {
      if ((numero >= 67250001 && numero <= 67700000) ||
          (numero >= 69050001 && numero <= 69500000) ||
          (numero >= 69500001 && numero <= 69950000) ||
          (numero >= 69950001 && numero <= 70400000) ||
          (numero >= 70400001 && numero <= 70850000) ||
          (numero >= 70850001 && numero <= 71300000) ||
          (numero >= 76310012 && numero <= 85139995) ||
          (numero >= 86400001 && numero <= 86850000) ||
          (numero >= 90900001 && numero <= 91350000) ||
          (numero >= 91800001 && numero <= 92250000)) {
        return false;
      }
    }

    return true;
  }

  void verificar() {
    String serie = serieController.text.trim();

    if (serie.isEmpty) {
      setState(() {
        resultado = "Ingrese un número de serie.";
        esValido = null;
      });
      return;
    }

    bool valido = verificarSerie(serie);

    setState(() {
      esValido = valido;

      if (valido) {
        resultado =
            "El billete de corte $corte Bs con número de serie $serie se encuentra habilitado.";
      } else {
        resultado =
            "El billete de corte $corte Bs con número de serie $serie NO se encuentra habilitado.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verificador de billetes habilitados"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Seleccione el corte del billete",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                /// SELECTOR DE CORTE MEJORADO
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.payments, color: Colors.green, size: 22),

                      const SizedBox(width: 8),

                      DropdownButton<String>(
                        value: corte,
                        underline: Container(),
                        isDense: true,
                        items: const [
                          DropdownMenuItem(value: "10", child: Text("10 Bs")),
                          DropdownMenuItem(value: "20", child: Text("20 Bs")),
                          DropdownMenuItem(value: "50", child: Text("50 Bs")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            corte = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                /// CAMPO NUMERO DE SERIE
                TextField(
                  controller: serieController,
                  decoration: const InputDecoration(
                    labelText: "Número de serie",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                ),

                const SizedBox(height: 25),

                /// BOTON VERIFICAR
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: verificar,
                    child: const Text(
                      "VERIFICAR",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// RESULTADO
                if (resultado.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: esValido == null
                          ? Colors.grey
                          : esValido!
                          ? Colors.green
                          : Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      resultado,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
