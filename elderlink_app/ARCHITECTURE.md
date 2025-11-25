# Application Flow

This document describes the user flow and application architecture for the ElderLink Login Application.

## User Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                        App Start                            │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────┐
│                    Login Screen                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Welcome to ElderLink                                 │  │
│  │  [Account Icon]                                       │  │
│  │                                                       │  │
│  │  Username: [_______________]                         │  │
│  │  Password: [_______________]                         │  │
│  │                                                       │  │
│  │  [Error Message Area]                                │  │
│  │                                                       │  │
│  │  [        Login Button        ]                      │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────┬──────────────┬──────────────────────────────┘
              │              │
      Valid   │              │  Invalid
  Credentials │              │  Credentials
              │              │
              ▼              ▼
    ┌─────────────┐   ┌──────────────────┐
    │  Loading    │   │  Show Error      │
    │  Indicator  │   │  "Invalid        │
    │             │   │  username or     │
    │  [Spinner]  │   │  password"       │
    └──────┬──────┘   └─────────┬────────┘
           │                    │
           │                    │ User retries
           ▼                    │
    ┌──────────────────────────┘
    │
    ▼
┌─────────────────────────────────────────────────────────────┐
│                     Home Screen                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Home                              [Logout Button]    │  │
│  ├───────────────────────────────────────────────────────┤  │
│  │                                                       │  │
│  │           [Success Checkmark Icon]                   │  │
│  │                                                       │  │
│  │           Login Successful!                          │  │
│  │                                                       │  │
│  │     Welcome to ElderLink Dashboard                   │  │
│  │                                                       │  │
│  └───────────────────────────────────────────────────────┘  │
└───────────────────────────┬─────────────────────────────────┘
                            │
                            │ User clicks Logout
                            │
                            ▼
                   ┌─────────────────┐
                   │  Navigate to    │
                   │  Login Screen   │
                   └─────────────────┘
```

## State Management Flow

```
Login Screen State Flow:
┌────────────────┐
│  Initial State │
│  - Empty forms │
│  - No errors   │
└───────┬────────┘
        │
        │ User enters credentials
        ▼
┌────────────────┐
│   Form Filled  │
│  - Validation  │
│    active      │
└───────┬────────┘
        │
        │ User taps Login
        ▼
┌────────────────┐     ┌─────────────────┐
│ Validation OK? │────►│ Show validation │
│                │ No  │     errors      │
└───────┬────────┘     └─────────────────┘
        │ Yes
        ▼
┌────────────────┐
│ Loading State  │
│  - Disable btn │
│  - Show spinner│
└───────┬────────┘
        │
        │ Simulate API call (1s)
        ▼
┌────────────────┐     ┌─────────────────┐
│ Check Creds    │────►│  Show error     │
│ admin/pass123? │ No  │  Stay on screen │
└───────┬────────┘     └─────────────────┘
        │ Yes
        ▼
┌────────────────┐
│   Navigate to  │
│   Home Screen  │
└────────────────┘
```

## Component Architecture

```
┌─────────────────────────────────────────────────────────┐
│                        main.dart                        │
│  ┌───────────────────────────────────────────────────┐  │
│  │                   MyApp                           │  │
│  │  - MaterialApp configuration                     │  │
│  │  - Theme setup                                   │  │
│  │  - Initial route: LoginScreen                   │  │
│  └───────────────────────────────────────────────────┘  │
└──────────────────────┬──────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────┐
│              screens/login_screen.dart                  │
│  ┌───────────────────────────────────────────────────┐  │
│  │               LoginScreen                         │  │
│  │  - StatefulWidget                                │  │
│  │  - Form with GlobalKey                           │  │
│  │  - TextEditingControllers                        │  │
│  │  - Validation logic                              │  │
│  │  - Authentication simulation                     │  │
│  └───────────────────────────────────────────────────┘  │
│                                                         │
│  ┌───────────────────────────────────────────────────┐  │
│  │               HomeScreen                          │  │
│  │  - StatelessWidget                               │  │
│  │  - Success message display                       │  │
│  │  - Logout button                                 │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

## Test Architecture

```
┌────────────────────────────────────────────────────────┐
│                   Test Structure                       │
└────────────────────────────────────────────────────────┘
           │
           ├── test/
           │   └── widget_test.dart
           │       - Test LoginScreen renders
           │       - Test form fields work
           │       - Test text input
           │
           └── integration_test/
               └── login_test.dart
                   ├── Successful login flow
                   ├── Failed login flow
                   ├── Empty username validation
                   ├── Empty password validation
                   ├── Logout flow
                   └── Loading state verification
```

## Navigation Flow

```
Navigation Stack:

Initial:
┌──────────────┐
│ LoginScreen  │
└──────────────┘

After Successful Login:
┌──────────────┐
│ HomeScreen   │  ← Current (LoginScreen replaced)
└──────────────┘

After Logout:
┌──────────────┐
│ LoginScreen  │  ← Current (HomeScreen replaced)
└──────────────┘
```

## Data Flow

```
User Input Flow:
┌─────────────┐     ┌──────────────────┐     ┌─────────────┐
│   User      │────►│ TextController   │────►│   State     │
│   Types     │     │  .text property  │     │  Variable   │
└─────────────┘     └──────────────────┘     └─────────────┘
                                                     │
                                                     ▼
                                              ┌─────────────┐
                                              │  Validation │
                                              │   Logic     │
                                              └─────────────┘
                                                     │
                                                     ▼
                                              ┌─────────────┐
                                              │ Auth Check  │
                                              └─────────────┘
                                                     │
                                                     ▼
                                              ┌─────────────┐
                                              │  Navigate   │
                                              │  or Error   │
                                              └─────────────┘
```

## Key Features

### 1. Form Validation
- Client-side validation before submission
- Empty field detection
- User-friendly error messages

### 2. Loading States
- Visual feedback during authentication
- Disabled button to prevent double-submission
- Spinner indicator

### 3. Error Handling
- Clear error messages
- Non-intrusive error display
- Maintains user input on error

### 4. Navigation
- Clean navigation using `pushReplacement`
- No navigation stack buildup
- Prevents back button to logged-out state

### 5. Testability
- Key-based widget identification
- Predictable state transitions
- Isolated business logic

## Credentials

The application uses hardcoded credentials for demonstration:

```dart
if (username == 'admin' && password == 'password123') {
  // Success path
} else {
  // Error path
}
```

In a production application, this would be replaced with:
- API calls to authentication service
- JWT token management
- Secure credential storage
- Password encryption
- Session management

## Future Enhancements

Potential additions to the application:
1. Remember Me functionality
2. Password visibility toggle
3. Forgot Password flow
4. OAuth/Social login
5. Biometric authentication
6. Session timeout handling
7. Multi-factor authentication
8. User registration flow
