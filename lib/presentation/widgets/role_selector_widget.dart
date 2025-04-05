import 'package:flutter/material.dart';

class RoleSelectorWidget extends StatelessWidget {
  final String? initialRole;

  const RoleSelectorWidget({
    super.key,
    this.initialRole,
  });

  @override
  Widget build(BuildContext context) {
    // List of available roles
    final roles = [
      'Product Designer',
      'Flutter Developer',
      'QA Tester',
      'Product Owner',
      'UX Researcher',
      'Full-stack Developer',
      'Project Manager',
      'DevOps Engineer',
    ];

    return Container(
      padding: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.0),
          topRight: Radius.circular(14.0),
        )
      ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: roles.length,
        itemBuilder: (context, index) {
          final role = roles[index];
          final isSelected = initialRole == role;

          return ListTile(
            visualDensity: VisualDensity(
              horizontal: -1,
              vertical: -4,
            ),
            title: Text(
              role,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
            onTap: () => Navigator.pop(context, role),
          );
        }, separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.grey[300]);
      },
      ),
    );
  }
}
