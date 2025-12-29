import 'package:flutter/material.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controllers to manage the text in the form fields
  late final TextEditingController _nameController;
  late final TextEditingController _flatController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Pre-fill the form with existing user data
    _nameController = TextEditingController(text: 'Kate Sujal Shyam');
    _flatController = TextEditingController(text: 'B-702');
    _emailController = TextEditingController(text: 'kate.s@example.com');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _flatController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // TODO: Implement logic to save the updated profile data
              Navigator.pop(context); // Go back to the profile screen
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    child: Icon(Icons.camera_alt, size: 20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Full Name'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _flatController,
            decoration: const InputDecoration(labelText: 'Flat Number'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email Address'),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}