# Nesty platform readiness review — 2026-10-23

## Executive assessment

The public listing path and the production web and mobile web builds are operational. The 31 non-demo listings are published under the active **Achref Agency** account, and the production site renders Djerba city data. The reviewed web and mobile changes are deployed.

This review does not certify the entire SaaS as bug-free or ready for unrestricted commercial launch. Authenticated end-to-end journeys were not exercised with real test accounts, listing availability still needs agency confirmation, payment processing is not integrated, and security/performance advisor findings remain.

## Inventory and data checks

Read-only checks against the production Supabase project found:

- **31 published, non-demo listings**; one additional non-demo listing remains pending moderation and is not public.
- All 31 public rows are attributed to the active **Achref Agency** account. Its profile email matches the agency email supplied by the owner.
- All 31 have a title, city, positive price, and either a cover image or gallery image.
- All current public rows are marked short-term. City distribution: Aghir 4, Arkou 2, Houmt SOUK 1, Mezraya 2, Midoun 8, Nadhour 1, Tezdaine 11, Zone touristique 2.
- The schema has **two active reservations**, no manual availability-block rows, and no `available_from` value on any of the 31 listings. The listing and booking dates therefore still need an agency calendar review before making date-specific availability promises.

These are database consistency checks. Property details, current availability, ownership, image rights, and the underlying agency authorization were not independently checked against owners or source documents during this software review.

## Changes made

- Added production-safe listing visibility rules so anonymous catalog reads return only published/active, non-demo listings; restricted public profile and reservation access.
- Applied additive production migrations for profile onboarding/status fields, reservations and availability, notification reconciliation, role/listing-write protection, and database policy cleanup.
- Added the public calendar block identifier required by the mobile parser. The public view exposes only listing ID and date range; it excludes host IDs and private reasons.
- Replaced the mobile account-deletion action with a support email request. Permanent account deletion was not added to the database.
- Fixed the mobile Vercel ignore rules. A dry-run caught that a broad rule would have excluded app code in `lib/core/services`; the corrected manifest is about 3.2 MB and keeps that code while excluding build artifacts, native targets, and the separate marketing site.
- Made the web canonical domain stable for sitemap and robots output.

## Test and deployment results

| Area | Result |
|---|---|
| Nesty Web | TypeScript, lint, and production build passed; 65/65 Vitest tests passed. |
| Nesty Base | TypeScript, lint, and production build passed. |
| Nesty Mobile | Flutter analysis passed; 36/36 Flutter tests passed; release web build passed. |
| Production HTTP smoke check | Web home, robots, sitemap, admin login, mobile home, Flutter bootstrap, and main Dart bundle returned HTTP 200. The web HTML included all eight Djerba city groups and did not show the empty-catalog message. |
| Database visibility | 31 public listings; anonymous reads of profiles/reservations and admin access checks were denied as intended. |

Production deployments:

- Web: `https://nesty-tn.vercel.app` — deployment `ETSs7xpzRPGLtPaQYHxnPbm3GQKm`.
- Mobile web: `https://nesty-tn-app.vercel.app` — deployment `4CyDjKJfPEEBnKUB9jQdLi4zu9V5`.
- Admin: `https://nesty-base.vercel.app` — source unchanged in this pass; login route returned HTTP 200.

The Flutter build reported that the optional WebAssembly dry run is incompatible with the current `flutter_tts` package; the regular JavaScript release build completed successfully. Next.js also reported an edge-runtime static-generation warning on one route; the production build completed successfully.

## Remaining launch risks and gaps

### Before date-specific booking claims

Ask Achref Agency to refresh availability for all 31 listings. The database currently has no manual availability blocks, every `available_from` field is empty, and two active reservations exist. Do not imply a particular date is confirmed based on the listing status alone.

### Before broad client onboarding

- Supabase Security Advisor still reports one `security_definer_view` error for `public_listing_availability`. The view is deliberately a sanitized public projection and is filtered to published, non-demo listings, but the advisor still flags owner-executed views. Review/replace this design if a zero-error security scan is a launch requirement.
- Supabase Auth leaked-password protection is disabled. Enable it in the Supabase Auth password settings.
- Other Supabase findings: two authenticated SECURITY DEFINER RPCs used by admin/verification flows; performance notices for nine unindexed foreign keys, 32 RLS init-plan cases, 34 multiple-permissive-policy cases, and 14 unused indexes. These require prioritization; unused indexes should not be removed solely from this snapshot.
- No payment-provider checkout integration was found. Subscription rows and paywall UI do not by themselves charge customers.
- No external crash/error monitoring service was found. Existing event tables contained 40 listing events (18 in the last 30 days) and 29 activity events (6 in the last 30 days); these are event-row counts, not unique users or conversion analytics.
- The app sends account deletion requests to support; it does not delete accounts automatically.
- Authenticated end-to-end flows (seeker booking, host response/calendar, admin moderation, support ticket handling, and paid subscription) were not run because no dedicated test accounts were supplied. No mutation tests were run against real reservations.

The authorization confirmation for the listings came from the owner in this session. The software checks establish that the rows are public, non-demo, structurally populated, and assigned to the requested agency; they cannot establish legal ownership or independently verify every property fact.

## Verification boundary

Passing unit, static, build, SQL-policy, and public HTTP checks reduce known risk, but they cannot prove that no bugs remain. A role-based browser walkthrough using disposable seeker, host, and admin test accounts, plus agency confirmation of availability, is still needed for a complete release sign-off.
