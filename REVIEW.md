# Code Review - SMS Console

This review analyzes `sms_console.dart` based on the requirements and best practices.

## Summary of Findings

| Severity | Finding | Location |
| :--- | :--- | :--- |
| Critical | Hardcoded API Key (Credential Leak) | Line 8 |
| Critical | Floating Point Precision for Money | Line 13, 73, 83 |
| High | PII Leakage in Logs | Line 65 |
| High | Lack of Tenant Isolation | Line 9 |
| High | Business Logic in UI | Line 31-137 |
| Medium | Fragile Error Handling | Line 55, 87 |
| Medium | Inefficient Network Usage | Line 110-116 |
| Medium | Missing Network/Server Error States | Line 53-60, 110 |

---

## Detailed Findings

### 1. Hardcoded API Key (Credential Leak)
- **Severity**: Critical
- **Location**: Line 8 (`const String kApiKey = '...'`)
- **What's wrong**: Sensitive credentials are hardcoded in the source code. This leads to credential leakage when committed to version control, allowing unauthorized access to the backend.
- **How to fix**: Use environment variables or a secure configuration provider (like `flutter_dotenv` or `--dart-define`) to inject the API key at build time.

### 2. Floating Point Precision for Money
- **Severity**: Critical
- **Location**: Lines 13, 73, 83
- **What's wrong**: The code uses `double` to store and calculate monetary values (`AppState.totalCost`, `rateFor`). Floating-point arithmetic is imprecise (e.g., `0.1 + 0.2 != 0.3`). The API contract explicitly warns: "Money... are decimal strings. Do not parse them into double."
- **How to fix**: Use a fixed-precision library like `decimal` or perform calculations in minor units (e.g., cents as integers) and format as strings only for display.

### 3. PII Leakage in Logs
- **Severity**: High
- **Location**: Line 65 (`print('Sending SMS to $phone: $body');`)
- **What's wrong**: Personal Identifiable Information (phone numbers and message content) is printed to the system logs. The API contract explicitly forbids logging recipients.
- **How to fix**: Remove the print statement or use a secure logger that masks PII.

### 4. Lack of Tenant Isolation
- **Severity**: High
- **Location**: Line 9 (`const String kTenantId = '...'`)
- **What's wrong**: The `X-Tenant-Id` header is required for every call, but here it's hardcoded to a single value. The app cannot support multiple tenants, and there's no mechanism to ensure a user only accesses their own tenant's data.
- **How to fix**: Implement a tenant selection or fetch the tenant ID from the authenticated user context. Ensure all repository calls include the correct `X-Tenant-Id` header.

### 5. Business Logic in UI (Massive View Controller)
- **Severity**: High
- **Location**: `_SmsConsolePageState` (Lines 31-137)
- **What's wrong**: Network calls, JSON parsing, state updates, and navigation logic are all inside the `State` class. This makes the code untestable, hard to maintain, and prone to bugs like `setState` called after the widget is unmounted.
- **How to fix**: Move business logic to a separate layer (Controller/ViewModel) using a state management library like GetX, Bloc, or Riverpod.

### 6. Fragile Error Handling
- **Severity**: Medium
- **Location**: Lines 55, 87
- **What's wrong**: `jsonDecode(res.body)` is called without checking the status code or whether the body is valid JSON. If the API returns a `502` or `429`, the app will crash with a `FormatException`. In `loadCosts`, there is no `try-catch` at all.
- **How to fix**: Check `res.statusCode` before decoding. Wrap network calls in `try-catch` blocks and map exceptions to user-friendly error messages.

### 7. Inefficient Network Usage (FutureBuilder in Build)
- **Severity**: Medium
- **Location**: Lines 110-116
- **What's wrong**: A `FutureBuilder` is placed directly in the `build` method, and its `future` is a direct call to `http.get`. This means every time the keyboard appears or the parent widget rebuilds, a new network request is triggered.
- **How to fix**: Store the `Future` in a variable in `initState` or, better yet, manage the data in a Controller/ViewModel.

### 8. Hardcoded Base URL
- **Severity**: Low
- **Location**: Line 7
- **What's wrong**: The base URL is hardcoded, making it impossible to switch between staging and production environments without modifying code.
- **How to fix**: Use a configuration class that environment-specific settings.
