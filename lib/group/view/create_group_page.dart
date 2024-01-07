import 'package:anu3/group/api/group_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateGroupPage extends ConsumerStatefulWidget {
  const CreateGroupPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends ConsumerState<CreateGroupPage> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();
  final List<bool> _selectedPrivacy = <bool>[true, false];
  bool _isCreating = false;

  addGroup(BuildContext context) {
    setState(() {
      _isCreating = true;
    });
    final isPrivate = _selectedPrivacy[0] == true;

    try {
      ref.read(groupRepositoryProvider).addGroup(name: _groupNameController.text, visibility: isPrivate);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Group created')),
      );
      _groupNameController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error creating group')),
      );
    }

    setState(() {
      _isCreating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Group'),
          elevation: double.infinity,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _groupNameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Group name',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a group name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                ToggleButtons(
                  constraints: BoxConstraints(
                    minWidth: (MediaQuery.of(context).size.width - 20) / _selectedPrivacy.length,
                  ),
                  isSelected: _selectedPrivacy,
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _selectedPrivacy.length; i++) {
                        _selectedPrivacy[i] = i == index;
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  selectedBorderColor: Colors.teal[400],
                  selectedColor: Colors.white,
                  fillColor: Colors.teal[400],
                  borderColor: Colors.teal[400],
                  color: Colors.teal[400],
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                      child: Text('Private'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                      child: Text('Public'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      // backgroundColor: Colors.teal[400],
                    ),
                    onPressed: _isCreating
                        ? null
                        : () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );

                              addGroup(context);
                            }
                          },
                    child: const Text('Create Group'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
