# ADR 0001: State Management Choice

## Status
Accepted

## Context
The application needs a predictable way to manage state, handle asynchronous operations (like sending SMS and fetching history), and decouple business logic from the UI. The project already had GetX integrated, but its usage was suboptimal.

## Decision
We decided to continue using **GetX** but with a strict architectural separation:
1. **Views**: Pure UI, observing state via `Obx` or `GetX`.
2. **Controllers**: Pure logic, handling state and interacting with repositories.
3. **Repositories**: Abstracting data source implementations.
4. **Bindings**: Managing dependency injection.

## Alternatives Considered
- **BLoC (Business Logic Component)**:
  - *Pros*: Highly structured, great for complex state, excellent testability.
  - *Cons*: High boilerplate, steeper learning curve for this specific project timeline (6-8 hours).
- **Riverpod**:
  - *Pros*: Compile-safe, no context-dependence, very flexible.
  - *Cons*: Requires changing the root widget structure and adapting existing GetX-based utilities (like `Get.to`, `Get.snackbar`).

## Rationale
GetX was chosen for its low boilerplate and the speed of development it enables, which is crucial for a 6-8 hour turnaround. By applying a clean architecture approach (Data/Domain/Presentation layers), we mitigated common "GetX mess" issues where logic is scattered.

## Consequences
- Development speed is high.
- Logic is easily testable in the Controller layer.
- Future transitions to other state management (like BLoC) would be easier because the business logic is already decoupled from the UI.
