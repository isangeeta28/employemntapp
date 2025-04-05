import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Employee extends Equatable {
  final String id;
  final String name;
  final String role;
  final DateTime startDate;
  final DateTime? endDate;

  const Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.startDate,
    this.endDate,
  });

  Employee copyWith({
    String? id,
    String? name,
    String? role,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  factory Employee.create({
    required String name,
    required String role,
    required DateTime startDate,
    DateTime? endDate,
  }) {
    return Employee(
      id: const Uuid().v4(),
      name: name,
      role: role,
      startDate: startDate,
      endDate: endDate,
    );
  }

  // Convert Employee to JSON format for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
    };
  }

  // Create Employee from JSON format
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      startDate: DateTime.fromMillisecondsSinceEpoch(json['startDate']),
      endDate: json['endDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['endDate'])
          : null,
    );
  }

  bool get isCurrent => endDate == null || endDate!.isAfter(DateTime.now());

  @override
  List<Object?> get props => [id, name, role, startDate, endDate];
}