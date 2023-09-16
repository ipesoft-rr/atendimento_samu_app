import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmergencyDetails extends StatefulWidget {
  const EmergencyDetails({super.key});

  @override
  State<EmergencyDetails> createState() => _EmergencyDetailsState();
}

class _EmergencyDetailsState extends State<EmergencyDetails> {
  String forwho = '';
  String location = '';
  String emergencyType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding:
              const EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 32),
          children: [
            Row(
              children: [
                ChoiceChip(
                  selected: forwho == 'for-me',
                  label: const Text('Para mim'),
                  onSelected: (newState) {
                    setState(() {
                      forwho = 'for-me';
                    });
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                ChoiceChip(
                  selected: forwho == 'for-another-person',
                  label: const Text('Para outra pessoa'),
                  onSelected: (newState) {
                    setState(() {
                      forwho = 'for-another-person';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Qual a emergência?',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text('Emergências comuns em Boa Vista'),
            const SizedBox(
              height: 24,
            ),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  selected: emergencyType == 'traffic-accident',
                  label: const Text('Acidente de trânsito'),
                  onSelected: (newState) {
                    setState(() {
                      emergencyType = 'traffic-accident';
                    });
                  },
                ),
                ChoiceChip(
                  selected: emergencyType == 'tumble',
                  label: const Text('Queda'),
                  onSelected: (newState) {
                    setState(() {
                      emergencyType = 'tumble';
                    });
                  },
                ),
                ChoiceChip(
                  selected: emergencyType == 'firearm',
                  label: const Text('Acidente c/ arma de fogo'),
                  onSelected: (newState) {
                    setState(() {
                      emergencyType = 'firearm';
                    });
                  },
                ),
                ChoiceChip(
                  selected: emergencyType == 'fainting',
                  label: const Text('Desmaio'),
                  onSelected: (newState) {
                    setState(() {
                      emergencyType = 'fainting';
                    });
                  },
                ),
                ChoiceChip(
                  selected: emergencyType == 'melle-weapon',
                  label: const Text('Acidente c/ arma branca'),
                  onSelected: (newState) {
                    setState(() {
                      emergencyType = 'melle-weapon';
                    });
                  },
                ),
                ChoiceChip(
                  selected: emergencyType == 'drawing',
                  label: const Text('Afogamento'),
                  onSelected: (newState) {
                    setState(() {
                      emergencyType = 'drawing';
                    });
                  },
                ),
                ChoiceChip(
                  selected: emergencyType == 'electric-shock',
                  label: const Text('Choque elétrico'),
                  onSelected: (newState) {
                    setState(() {
                      emergencyType = 'electric-shock';
                    });
                  },
                ),
                ChoiceChip(
                  selected: emergencyType == 'suspected-heart-attack',
                  label: const Text('Suspeita de infarto'),
                  onSelected: (newState) {
                    setState(() {
                      emergencyType = 'suspected-heart-attack';
                    });
                  },
                ),
                ChoiceChip(
                  selected: emergencyType == 'custom',
                  label: const Text('Outro'),
                  onSelected: (newState) {
                    setState(() {
                      emergencyType = 'custom';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Localização',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    selected: location == 'my-position',
                    label: const Text('Minha localização'),
                    onSelected: (newState) {
                      setState(() {
                        location = 'my-position';
                      });
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ChoiceChip(
                    selected: location == 'set-on-map',
                    label: const Text('Digitar endereço'),
                    onSelected: (newState) {
                      setState(() {
                        location = 'set-on-map';
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  context.pop('/');
                },
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  context.push('/chat');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                child: const Text(
                  'Solicitar ajuda',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
