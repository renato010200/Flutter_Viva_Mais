import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MonitoramentoSaudeApp());
}

class MonitoramentoSaudeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        title: 'Viva Mais',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            bodyMedium: TextStyle(fontSize: 18, color: Colors.grey[800]),
            bodyLarge: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => TelaLogin(),
          '/cadastro': (context) => TelaCadastro(),
          '/inicio': (context) => TelaInicial(),
          '/dados': (context) => TelaDadosSaude(),
          '/historico': (context) => TelaHistorico(),
          '/progresso': (context) => TelaProgresso(),  
        },
      ),
    );
  }
}

class UserData extends ChangeNotifier {
  String? nome;
  String? email;
  int idade = 30;
  List<UserHealthData> healthDataHistory = [];  

  void setUserData(String nome, String email, int idade) {
    this.nome = nome;
    this.email = email;
    this.idade = idade;
    notifyListeners();
  }

  
  void updateHealthData(double peso, double altura, int pressao, int glicose, DateTime dataConsulta) {
    var data = UserHealthData(peso, altura, pressao, glicose, dataConsulta);
    healthDataHistory.add(data);
    notifyListeners();
  }

  
  double calculateIMC(double peso, double altura) {
    if (altura > 0) {
      return peso / (altura * altura);
    }
    return 0.0;
  }

  String getIMCDiagnosis(double imc) {
    if (imc < 18.5) {
      return "Abaixo do peso";
    } else if (imc >= 18.5 && imc <= 24.9) {
      return "Peso normal";
    } else if (imc >= 25 && imc <= 29.9) {
      return "Sobrepeso";
    } else {
      return "Obesidade";
    }
  }
}

class UserHealthData {
  final double peso;
  final double altura;
  final int pressao;
  final int glicose;
  final DateTime dataConsulta;

  UserHealthData(this.peso, this.altura, this.pressao, this.glicose, this.dataConsulta);
}

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: const Color(0xFFF1F8E9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Bem-vindo de volta!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 40),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _senhaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/inicio');
              },
              child: Text('Entrar'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cadastro');
              },
              child: Text('Ainda não tem uma conta? Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _idadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: const Color(0xFFF1F8E9),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Cadastre-se para começar a monitorar sua saúde',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 40),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _senhaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _idadeController,
              decoration: InputDecoration(
                labelText: 'Idade',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.cake),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Provider.of<UserData>(context, listen: false).setUserData(
                  _nomeController.text,
                  _emailController.text,
                  int.parse(_idadeController.text),
                );
                Navigator.pushNamed(context, '/inicio');
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Viva Mais'),
        backgroundColor: Colors.green,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade300, Colors.green.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: _animation.value * 100,
                  );
                },
              ),
              SizedBox(height: 30),
              Text(
                'Bem-vindo(a), ${userData.nome ?? 'Usuário'}!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Aqui você pode monitorar sua saúde, controlar dados vitais e melhorar sua qualidade de vida.',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Progresso',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Dados de Saúde',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/inicio');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/progresso');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/historico');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/dados');
          }
        },
      ),
    );
  }
}

class TelaDadosSaude extends StatefulWidget {
  @override
  _TelaDadosSaudeState createState() => _TelaDadosSaudeState();
}

class _TelaDadosSaudeState extends State<TelaDadosSaude> {
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _pressaoController = TextEditingController();
  final _glicoseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Dados de Saúde'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Preencha seus dados de saúde', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 20),
            TextField(
              controller: _pesoController,
              decoration: InputDecoration(labelText: 'Peso (kg)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.accessibility)),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _alturaController,
              decoration: InputDecoration(labelText: 'Altura (m)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.height)),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _pressaoController,
              decoration: InputDecoration(labelText: 'Pressão Arterial (mmHg)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.favorite)),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _glicoseController,
              decoration: InputDecoration(labelText: 'Glicose (mg/dL)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.local_hospital)),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                userData.updateHealthData(
                  double.parse(_pesoController.text),
                  double.parse(_alturaController.text),
                  int.parse(_pressaoController.text),
                  int.parse(_glicoseController.text),
                  DateTime.now(),  
                );
                Navigator.pushNamed(context, '/dados');
              },
              child: Text('Salvar Dados'),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaHistorico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Saúde'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Histórico de Dados de Saúde',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 20),
            for (var i = 0; i < userData.healthDataHistory.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Consulta ${i + 1} - ${userData.healthDataHistory[i].dataConsulta.toLocal()}'),
                  Text('Peso: ${userData.healthDataHistory[i].peso} kg'),
                  Text('Altura: ${userData.healthDataHistory[i].altura} m'),
                  Text('Pressão: ${userData.healthDataHistory[i].pressao} mmHg'),
                  Text('Glicose: ${userData.healthDataHistory[i].glicose} mg/dL'),
                  SizedBox(height: 10),
                  if (i > 0) _compareProgress(userData.healthDataHistory[i], userData.healthDataHistory[i - 1]),
                  Divider(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _compareProgress(UserHealthData current, UserHealthData previous) {
    final imcCurrent = current.peso / (current.altura * current.altura);
    final imcPrevious = previous.peso / (previous.altura * previous.altura);
    final imcChange = imcCurrent - imcPrevious;
    final trend = imcChange > 0
        ? 'Você teve uma regressão no IMC.'
        : (imcChange < 0 ? 'Você melhorou seu IMC.' : 'IMC está estável.');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mudança no IMC: ${imcChange.toStringAsFixed(2)}'),
        Text(trend, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class TelaProgresso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final latestData = userData.healthDataHistory.isNotEmpty
        ? userData.healthDataHistory.last
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Progresso'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: latestData == null
            ? Center(child: Text('Ainda não há dados registrados.'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Progresso de Saúde:', style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: 20),
                  Text('Peso Atual: ${latestData.peso} kg'),
                  Text('Altura Atual: ${latestData.altura} m'),
                  Text('Pressão Arterial: ${latestData.pressao} mmHg'),
                  Text('Glicose: ${latestData.glicose} mg/dL'),
                  SizedBox(height: 20),
                  Text('Diagnóstico do IMC: ${userData.getIMCDiagnosis(userData.calculateIMC(latestData.peso, latestData.altura))}'),
                ],
              ),
      ),
    );
  }
}
