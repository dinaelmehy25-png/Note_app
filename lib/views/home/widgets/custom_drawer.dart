import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
              Navigator.pop(context); // إغلاق الـ Drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Create new label'),
            onTap: () {
              Navigator.pop(context); // إغلاق الـ Drawer قبل فتح الـ Dialog
              _showCreateLabelDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.archive_outlined),
            title: const Text('Archive'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Trash'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showCreateLabelDialog(BuildContext context) {
    final TextEditingController labelController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Create new label'),
          content: TextField(
            controller: labelController,
            decoration: const InputDecoration(hintText: 'Enter label name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (labelController.text.trim().isNotEmpty) {
                  // تنفيذ إضافة الـ Label هنا مستقبلاً
                }
                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}