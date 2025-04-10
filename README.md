# Employee Management App

A Flutter application for managing employee data with capabilities to add, edit, and delete employee records.

## Features

- **Employee Management**: Add, edit, and delete employee records
- **Role Selection**: Choose from predefined roles for employees
- **Date Range Selection**: Set start and end dates for employment periods
- **Current vs Previous Employees**: Automatic categorization based on end date
- **Data Persistence**: Local storage using SharedPreferences
- **State Management**: Built with BLoC pattern for efficient state management
- **Responsive Design**: Works across all mobile screen resolutions

## Project Structure

```
employee_management_app/
├── lib/
│   ├── main.dart               # Entry point
│   ├── app.dart                # Application setup
│   ├── config/                 # Configuration
│   │   └── theme.dart          # App theme
│   ├── data/                   # Data layer
│   │   ├── models/             # Data models
│   │   │   └── employee.dart   # Employee model
│   │   └── repositories/       # Data repositories
│   │       └── employee_repository.dart
│   ├── logic/                  # Business logic
│   │   ├── blocs/              # BLoC state management
│   │   │   └── employee/       # Employee BLoC
│   │   └── services/           # Services
│   │       └── db_service.dart # Database service
│   └── presentation/           # UI layer
│       ├── screens/            # App screens
│       ├── widgets/            # Reusable widgets
```

## Getting Started

### Prerequisites

- Flutter SDK (2.5.0 or newer)
- Dart SDK (2.14.0 or newer)

## Implementation Details

### State Management

The app uses BLoC (Business Logic Component) pattern for state management:

- **EmployeeBloc**: Manages employee-related operations
- **EmployeeEvent**: Defines events like loading, adding, updating, and deleting employees
- **EmployeeState**: Represents different states of the employee data

### Data Persistence

Employee data is persisted locally using SharedPreferences, which:

- Saves employee records in JSON format
- Loads employee data on app startup
- Updates the storage when changes are made

### UI Components

The app includes the following key UI components:

- **Employee List Screen**: Displays current and previous employees
- **Add Employee Screen**: Form for adding new employees
- **Edit Employee Screen**: Form for editing existing employees
- **Date Picker Widget**: Custom calendar widget for selecting dates
- **Role Selector Widget**: Bottom sheet for selecting employee roles

## Screenshots

The app implements all screens from the provided Figma design, including:
- Empty state screen
- Employee list view
- Add/edit employee forms
- Date picker
- Role selector

## License

This project is licensed under the MIT License - see the LICENSE file for details.#   e m p l o y e m n t a p p  
 