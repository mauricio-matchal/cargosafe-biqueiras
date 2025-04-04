import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 243, 243, 1),
      body: Stack(
        children: [
          Positioned(
            top: -200,
            right: -0,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(57, 73, 106, 0.4),
                    blurRadius: 200,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                                CircularProgressIndicator(
                                  color: Color.fromRGBO(13, 186, 26, 1),
                                ),
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
                Button(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, .08),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              backgroundColor: WidgetStateProperty.all<Color>(
                Color.fromRGBO(13, 186, 26, 1),
              ),
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 16), // Even padding
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14), // Rounded corners
                ),
              ),
            ),
            onPressed: () {},
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
    );
  }
}
