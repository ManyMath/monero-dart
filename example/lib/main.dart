import 'package:flutter/material.dart';
import 'package:monero/monero.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monero Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Monero Wallet Demo'),
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
  String _mnemonic = '';
  String _primaryAddress = '';
  String _subaddress = '';
  bool _isLoading = false;

  void _generateWallet() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Generate mnemonic
      final mnemonic = generateMnemonic();

      // Generate primary address
      final primaryAddress = generateAddress(mnemonic);

      // Generate subaddress
      final subaddress = generateAddress(
        mnemonic,
        account: 0,
        index: 1,
      );

      setState(() {
        _mnemonic = mnemonic;
        _primaryAddress = primaryAddress;
        _subaddress = subaddress;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Generate a Monero Wallet',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_mnemonic.isNotEmpty) ...[
                _buildInfoCard('Mnemonic', _mnemonic),
                const SizedBox(height: 16),
                _buildInfoCard('Primary Address', _primaryAddress),
                const SizedBox(height: 16),
                _buildInfoCard('Subaddress (0,1)', _subaddress),
              ] else
                const Text(
                  'Press the button below to generate a new wallet',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isLoading ? null : _generateWallet,
        tooltip: 'Generate Wallet',
        icon: const Icon(Icons.generating_tokens),
        label: const Text('Generate Wallet'),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SelectableText(
              content,
              style: const TextStyle(fontSize: 14, fontFamily: 'monospace'),
            ),
          ],
        ),
      ),
    );
  }
}
