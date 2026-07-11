# ADR 0001: State Management Choice

## Status
**Accepted**

## Context
The application requires a robust way to manage asynchronous state (SMS sending, history pagination, analytics) while maintaining a high degree of decoupling between the business logic and the UI. The solution needed to be implemented within a tight 6-8 hour development window.

## Decision
We chose **GetX** as the primary state management and dependency injection solution, enforced with a strict **Clean Architecture** structure.

## Rationale
*   **Development Velocity**: GetX offers minimal boilerplate compared to BLoC or Redux, allowing more time to be spent on architecture and testing rather than boilerplate setup.
*   **Feature Completeness**: It provides built-in solutions for Navigation, Dependency Injection, and Theme management, reducing the need for multiple competing packages.
*   **Separation of Concerns**: By combining GetX with Domain-Driven Design (DDD), we ensure that logic resides in Controllers and UseCases, making the UI 100% reactive and logic-free.

## Alternatives Considered
1.  **BLoC**: Rejected due to high boilerplate and time constraints, though recognized as excellent for larger, long-term enterprise apps.
2.  **Riverpod**: A strong contender; however, GetX was prioritized for its integrated "all-in-one" utility suite which sped up the initial scaffolding.

## Consequences
*   **Testability**: Business logic in Controllers is easily testable without Flutter dependencies.
*   **Simplicity**: The learning curve for future maintainers is low.
*   **Architecture Debt**: To avoid "GetX Sprawl," we strictly isolated GetX to the Presentation layer, ensuring the Domain layer remains pure Dart.
