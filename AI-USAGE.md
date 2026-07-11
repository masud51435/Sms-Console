# AI Usage & Manual Refinement Report

This report provides transparency on how AI tools were utilized during the development process and highlights the manual engineering efforts required to meet the high-quality standards of the project.

## 🤖 AI-Assisted Components

AI was used for initial scaffolding and repetitive tasks:
*   **Data Models**: Generated basic `fromJson`/`toJson` boilerplate based on `API-CONTRACT.md`.
*   **UI Layouts**: Created the initial skeleton for the responsive Grid/Column layouts.
*   **Documentation Drafts**: Provided the initial structure for ADR and README files.

## 🧠 Manual Engineering (Critical Fixes)

The following core components were manually engineered or significantly refactored to override suboptimal AI suggestions:

1.  **High-Precision Money Handling**: AI tools consistently suggested using `double`. I manually implemented a `String`-based fixed-precision architecture to satisfy the `API-CONTRACT.md` precision requirements.
2.  **Network Resilience & Interceptors**: Manually configured `Dio` interceptors to handle `X-Tenant-Id` injection and global error mapping for 429/502 status codes.
3.  **Clean Architecture Separation**: Reorganized AI-generated "all-in-one" files into strict Domain, Data, and Presentation layers.
4.  **Security Audit**: Manually identified and removed hardcoded credentials and PII logging that AI suggestions failed to catch.
5.  **Infinite Scrolling Logic**: Manually implemented the cursor-based pagination logic for the message history list to ensure efficient memory usage.

## 🏁 Conclusion
AI served as a powerful "co-pilot" for speed, while manual engineering was the "pilot" ensuring security, precision, and architectural integrity.
