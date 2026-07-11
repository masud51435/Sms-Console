# AI Usage Report

## Generated Parts
- **Models and Data Layer**: Scaffolding for the models based on `API-CONTRACT.md` was generated and then manually refined.
- **UI Components**: The initial structure of `SmsSendForm` and `CostBreakdownCard` was generated.
- **ADR and README**: Drafts were generated based on project context.

## Where the AI was wrong
- **Money Handling**: The AI initially suggested using `double` for the `cost` field in the models. I manually changed these to `String` and ensured that all display logic treats them as fixed-precision strings as required by the contract.
- **Responsiveness**: The AI suggested simple `MediaQuery.of(context).size.width` checks. I replaced this with a `LayoutBuilder` based desktop/mobile layout split to ensure a better "console" feel on large screens.
- **Error Handling**: The initial suggestion was to catch errors in the controller and print them. I integrated the project's existing `ApiClient` and `AppInterceptor` to handle errors globally and show user-friendly toasts.

## Parts written manually
- **Architecture Setup**: Deciding on the feature-first folder structure and layer separation.
- **Tenant Isolation logic**: Ensuring `X-Tenant-Id` is passed in the headers of every request.
- **Review (REVIEW.md)**: Analyzing the `sms_console.dart` for security and precision flaws.
