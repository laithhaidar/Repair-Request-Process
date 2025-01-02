import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: RepairProcess(),
    ));

class RepairProcess extends StatefulWidget {
  RepairProcess({Key? key}) : super(key: key);

  @override
  _RepairProcessState createState() => _RepairProcessState();
}

class _RepairProcessState extends State<RepairProcess> {
  bool isRepairSuccessful = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Repair Request Process"),
      ),
      body: Column(
        children: [
          StepWidget(stepName: "Receive Repair Request", icon: Icons.receipt),
          StepWidget(stepName: "Verify Warranty", icon: Icons.assignment),
          StepWidget(
              stepName: "Is the Device Under Warranty?",
              icon: Icons.assignment_turned_in),
          RepairStepWidget(isSuccessful: isRepairSuccessful),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isRepairSuccessful = true;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Repair process started.")),
                );
              });
            },
            child: const Text('Start Repair Process'),
          ),
        ],
      ),
    );
  }
}

class StepWidget extends StatelessWidget {
  final String stepName;
  final IconData icon;

  const StepWidget({required this.stepName, required this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(stepName),
      leading: CircleAvatar(child: Icon(icon)),
    );
  }
}

class RepairStepWidget extends StatelessWidget {
  final bool isSuccessful;

  const RepairStepWidget({required this.isSuccessful, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: StepWidget(stepName: "Repair Device", icon: Icons.build),
      children: [
        StepWidget(stepName: "Test Device", icon: Icons.desktop_windows),
        StepWidget(
            stepName: "Was the Repair Successful?",
            icon: isSuccessful ? Icons.check : Icons.close),
        Text("Repair Status: ${isSuccessful ? 'Successful' : 'Unsuccessful'}"),
        RepairLoopStepWidget(),
      ],
    );
  }
}

class RepairLoopStepWidget extends StatelessWidget {
  const RepairLoopStepWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title:
          StepWidget(stepName: "Repeat Repair and Testing", icon: Icons.loop),
      children: [
        StepWidget(stepName: "Repair Device Again", icon: Icons.build),
        StepWidget(stepName: "Test Device Again", icon: Icons.desktop_windows),
        StepWidget(stepName: "Was the Repair Successful?", icon: Icons.check),
      ],
    );
  }
}
