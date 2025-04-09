import 'package:biqueiras/ui/biqueiras_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      color: Colors.blue,
      theme: ThemeData(
        fontFamily: 'Inter', // ← Must match 'family' in pubspec.yaml

        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          // Default text style
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ButtonStatus _status = ButtonStatus.unavailable;
  bool foundDevice = false;
  bool turnedOn = false;

  @override
  void initState() {
    super.initState();
    _checkBluetoothDevice();
  }

  Future<void> _checkBluetoothDevice() async {
    try {
      // Verifica se o Bluetooth está ligado
      BluetoothAdapterState adapterState = await FlutterBluePlus.adapterState.first;
      if (adapterState != BluetoothAdapterState.on) {
        setState(() {
          _status = ButtonStatus.unavailable;
        });
        return;
      } else if(adapterState == BluetoothAdapterState.on) {
        setState(() {
          turnedOn = true;
        });
      }


      // Começa a escanear
      await FlutterBluePlus.startScan(timeout: Duration(seconds: 5));

      // Nome do dispositivo que você quer detectar
      const nomeDoDispositivo = "Biqueiras CargoSafe";

      bool dispositivoEncontrado = false;

      // Escuta os resultados do scan
      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult result in results) {
          if (result.device.name == nomeDoDispositivo) {
            dispositivoEncontrado = true;
            FlutterBluePlus.stopScan(); // para o scan assim que encontrar
            setState(() {
              foundDevice = true;
              _status = ButtonStatus.active;
            });
            break;
          }
        }

        if (!dispositivoEncontrado) {
          setState(() {
            foundDevice = false;
            _status = ButtonStatus.unavailable;
          });
        }
      });
    } catch (e) {
      print("Erro ao verificar o dispositivo: $e");
      setState(() {
        foundDevice = false;
        _status = ButtonStatus.unavailable;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      body: Stack(
        children: [
          Positioned(
            top: -200,
            right: -30,
            child: Container(
              width: 500,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(250),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(57, 73, 106, 0.4),
                    blurRadius: 100,
                    spreadRadius: 100,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 32.0, 18.0, 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 18,),
                Center(
                  child: Text(
                    'Primeiros passos',
                    textWidthBasis: TextWidthBasis.parent,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 36.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Column(
                      children: [
                        Text(
                          "Ative o Bluetooth",
                          style: TextStyle(
                            letterSpacing: -0.2,
                            fontWeight: FontWeight.w700,
                            fontSize: 24.0,
                            color: Color.fromRGBO(21, 42, 86, 1),
                          ),
                        ),
                        !turnedOn
                          ? Text("Bluetooth desligado")
                          : Text("Bluetooth ligado"),
                        SizedBox(height: 48.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            spacing: 32.0,
                            children: [
                              Row(
                                spacing: 16.0,
                                children: [
                                  Text(
                                    "1.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28,
                                      wordSpacing: 28,
                                      color: Color.fromRGBO(21, 42, 86, 1),
                                    ),
                                  ),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          height: 1.2,
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: "Inter",
                                        ), // Default style
                                        children: [
                                          TextSpan(
                                            text: "Certifique-se de que as ",
                                          ),
                                          TextSpan(
                                            text: "Biqueiras CargoSafe",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ), // Medium weight
                                          ),
                                          TextSpan(text: " estejam ligadas."),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 16.0,
                                children: [
                                  Text(
                                    "2.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28,
                                      wordSpacing: 28,
                                      color: Color.fromRGBO(21, 42, 86, 1),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Ative o Bluetooth do seu celular.",
                                      style: TextStyle(height: 1.2),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 16.0,
                                children: [
                                  Text(
                                    "3.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 28,
                                      wordSpacing: 28,
                                      color: Color.fromRGBO(21, 42, 86, 1),
                                    ),
                                  ),
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          height: 1.2,
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: "Inter",
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                "Conecte-se ao dispositivo com o nome ",
                                          ),
                                          TextSpan(
                                            text: "\"Nome do dispositivo\"",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ), // Medium weight
                                          ),
                                          TextSpan(text: "."),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 56.0),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.04),
                                blurRadius: 12.0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16.0,
                              14.0,
                              16.0,
                              14.0,
                            ),
                            child: Row(
                              spacing: 20,
                              children: [
                                !foundDevice
                                  ? CircularProgressIndicator(
                                      color: Color.fromRGBO(13, 186, 26, 1),
                                    )
                                  : Icon(Icons.check, color: Color.fromRGBO(13, 186, 26, 1),),
                                
                                Expanded(
                                  child: Text(
                                    "Verificando conexão com Biqueiras CargoSafe...",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Button(status: _status),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum ButtonStatus { active, available, unavailable }

class Button extends StatelessWidget {
  final ButtonStatus status;

  const Button({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Determine background color based on status
    Color backgroundColor;
    Color foregroundColor;
    bool isDisabled = false;

    switch (status) {
      case ButtonStatus.active:
        backgroundColor = Color(0xFF0DBA1A);
        foregroundColor = Color.fromRGBO(255, 255, 255, 1); // green
        break;
      case ButtonStatus.available:
        backgroundColor = Colors.white;
        foregroundColor = Color.fromRGBO(0, 0, 0, 1);
        break;
      case ButtonStatus.unavailable:
        backgroundColor = Colors.white;
        foregroundColor = Color.fromRGBO(0, 0, 0, 1);
        isDisabled = true;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Opacity(
        opacity: isDisabled ? 0.4 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 12,
                color: Color.fromRGBO(0, 0, 0, .14),
              ),
            ],
          ),
          child: SizedBox(
            width: double.infinity,
            height: 50.0,
            child: TextButton(
              onPressed:
                  isDisabled
                      ? null
                      : () async {
                        final saved = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const BiqueirasPage(initialPageStatus: PageStatus.normal,),
                          ),
                        );
                      },
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(
                  foregroundColor,
                ),
                backgroundColor: WidgetStateProperty.all<Color>(
                  backgroundColor,
                ),
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 16),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              child: Text(
                "Começar",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
