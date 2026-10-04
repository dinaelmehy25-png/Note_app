import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            child: Text(
              'Google Keep',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lightbulb_outline),
            title: const Text('Notes'),
            onTap: () {
              Get.back(); 
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Create new label'),
            onTap: () {
              Get.back();
              _showCreateLabelDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.archive_outlined),
            title: const Text('Archive'),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Trash'),
            onTap: () {
              Get.back(); 
            },
          ),
        ],
      ),
    );
  }

 
  void _showCreateLabelDialog(BuildContext context) {
    final TextEditingController labelController = TextEditingController();
    Get.defaultDialog(
      title: 'Create new label',
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: labelController,
          decoration: const InputDecoration(hintText: 'Enter label name'),
        ),
      ),
      textConfirm: 'Save',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        if (labelController.text.trim().isNotEmpty) {
         
        }
        Get.back();
      },
    );
  }
}