import 'package:flutter/material.dart';

void main() {
  runApp(MonitoramentoSaudeApp());
}

class MonitoramentoSaudeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viva Mais',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TelaInicial(),
        '/dados': (context) => TelaDadosSaude(),
      },
    );
  }
}

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Viva Mais'),
      ),
      backgroundColor: const Color.fromARGB(255, 189, 244, 252),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo ao Viva Mais!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dados');
              },
              child: Text('Ir para Dados de Saúde'),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaDadosSaude extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados de Saúde'),
      ),
      backgroundColor: Colors.cyan,
      body: Center(
        child: Text(
          'Aqui você pode monitorar seus dados de saúde.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}