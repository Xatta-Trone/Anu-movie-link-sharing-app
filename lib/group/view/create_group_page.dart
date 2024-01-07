import 'package:anu3/group/group.dart';
import 'package:anu3/group/providers/group_list_notifier_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class CreateGroupPage extends ConsumerStatefulWidget {
  String? groupId;
  CreateGroupPage({super.key, this.groupId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends ConsumerState<CreateGroupPage> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();
  // 1st private 2nd public
  final List<bool> _isPublic = <bool>[false, true];
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    if (widget.groupId != null) {
      if (kDebugMode) {
        print(widget.groupId);
      }
      GroupModel group = ref.read(groupListNotifierProvider.notifier).getGroupById(int.parse(widget.groupId!));
      _groupNameController.text = group.name;
      _isPublic[0] = group.visibility == false;
      _isPublic[1] = group.visibility == true;
    }
  }

  handleSubmit(BuildContext context) {
    setState(() {
      _isCreating = true;
    });
    final isPublic = _isPublic[1] == true;
    // ... Your code here ...
    ScaffoldMessenger.of(context).clearSnackBars();
    try {
      if (widget.groupId == null) {
        ref.read(groupListNotifierProvider.notifier).addGroup(name: _groupNameController.text, visibility: isPublic);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Group created...')),
        );
      } else {
        if (kDebugMode) {
          print(
            'updating....$isPublic',
          );
        }
        ref.read(groupListNotifierProvider.notifier).updateGroup(id: widget.groupId!, name: _groupNameController.text, visibility: isPublic);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Group updated...')),
        );
      }

      _groupNameController.clear();
      if (mounted) {
        // sleep(const Duration(seconds: 1));
        Navigator.pop(context);
      }
    } catch (e) {
      if (widget.groupId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error creating group')),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error updating group')),
        );
      }
     
    }

    setState(() {
      _isCreating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.groupId == null ? 'Create' : 'Update'} Group'),
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
                    minWidth: (MediaQuery.of(context).size.width - 20) / _isPublic.length,
                  ),
                  isSelected: _isPublic,
                  onPressed: (int index) {
                    setState(() {
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _isPublic.length; i++) {
                        _isPublic[i] = i == index;
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

                              handleSubmit(context);
                            }
                          },
                    child: Text(widget.groupId == null ? 'Create' : 'Update'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
