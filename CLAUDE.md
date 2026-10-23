# CLAUDE.md — Nesty Platform Context

> **Read this file first in every Nesty session.** It is the single source of truth for what
> Nesty is, what stage it is at, and what is in / out of scope. Technical claims in this file
> are verified against the repos — see "Verified repo layout" for the last verification date.

## What Nesty is

Nesty is a vertical SaaS platform for real estate agencies in Tunisia and North Africa. It is being built by Achref Ben Yaagoub (technical founder, software engineer + UX/UI designer) and Ghofrane Farhaoui (co-founder).

The long-term vision is a multi-vertical "operating system for small agencies" (real estate → travel → car rental → other agency verticals), but the current and only focus for the next 12 months is real estate agencies in Tunisia, starting in the Sousse region.

**Do not suggest features, architectural decisions, or content that assume multi-vertical support in the near term.** The platform must feel single-purpose and deeply specialized for real estate until at least 10 paying agencies are onboarded.

## The three applications

Nesty consists of three separate applications sharing one Supabase backend:

1. **Nesty Base** (`nesty-base/`) — Internal admin console. Next.js on Vercel. Users: Nesty staff only. Capabilities: global dashboard, verification approval/refusal, agency management, user management (ban/unban, role assignment), tickets/support, analytics, live activity feed.

2. **Nesty Web** (`nesty-web/`, hosted at nesty-tn.vercel.app) — Public landing page + agency dashboard. Next.js on Vercel. Users: real estate agencies (agency owners and their agents). Capabilities: listings CRUD, calendar of reservations, incident reporting, support chat, profile/settings.

3. **Nesty Mobile** (`nesty/`) — **Flutter** app with three roles: Seeker, Partner, Agency. Currently in testing/verification phase. Seeker is the primary role (end-user looking for properties: rentals, purchases, short-term, long-term, colocation, villas, apartments). Features: search + filters, listing details, 3D tour mode, reservation/booking flow, identity verification (KYC), notifications, profile, auth.

**Critical architectural fact:** all three apps share ONE Supabase project. Row-Level Security is the single most important defense against cross-tenant data leaks. Any change to auth, roles, or RLS policies affects all three apps simultaneously.

**Second critical fact:** the Supabase schema is defined by migrations spread across **all three repos** (see counts below). No single repo shows the whole database. Any schema or RLS reasoning must consider all three migration directories together, or it will be wrong.

## Verified repo layout

*Last verified against the filesystem: 2026-08-01.*

```
C:\Users\Team_2\proejcts\Nesty\
├── CLAUDE.md              ← this file (platform-level context)
├── nesty\                 ← Flutter mobile app
│   ├── lib\ android\ ios\ assets\ test\
│   ├── pubspec.yaml  .metadata  analysis_options.yaml
│   ├── dart_defines.example.json   ← build-time config / secrets pattern
│   ├── landing\index.html          ← standalone static landing (separate from nesty-web)
│   ├── services\tour3d\            ← FastAPI: app.py, requirements.txt
│   └── supabase\migrations\        ← 15 .sql migrations
├── nesty-base\            ← Next.js admin console
│   ├── src\  .env.example  next.config.mjs  tsconfig.json
│   └── supabase\migrations\        ← 5 .sql migrations
├── nesty-web\             ← Next.js agency dashboard + landing
│   ├── src\ public\ docs\
│   ├── messages\          ← i18n: en.json, fr.json  (NO ar.json — see gaps)
│   ├── tailwind.config.ts  components.json  vitest.config.ts
│   └── supabase\migrations\        ← 3 .sql migrations
└── demo-video\            ← Remotion project for the sales demo video (not a product app)
```

**Verified dependency versions:**

| Repo | Stack |
|---|---|
| `nesty` | Flutter / Dart |
| `nesty-base` | Next.js 14.2, React 18.3.1, TypeScript 5.6.2, `@supabase/supabase-js` ^2.110.6 |
| `nesty-web` | Next.js 14.2, React 18.3.1, TypeScript 5.6.2, `@supabase/supabase-js` ^2.110.6, `next-intl` ^3.26.5, Tailwind 3.4.13, Vitest ^2.1.9 |
| `demo-video` | Remotion 4.0.502, React 19.2.3, Tailwind 4.0.0 |

Note `demo-video` is on React 19 / Tailwind 4 while the product apps are on React 18 / Tailwind 3 — they are unrelated toolchains, do not "align" them.

## Tech stack

- **Frontend web:** Next.js 14 (App Router), TypeScript, Tailwind CSS
- **Frontend mobile:** **Flutter / Dart** (not React Native — a previous version of this doc said Expo/React Native; that was wrong)
- **Backend:** Supabase (Postgres + Auth + Storage + RLS + Realtime + Edge Functions), shared across all three apps
- **3D tours:** `nesty/services/tour3d` — FastAPI service that turns room photos into a walkthrough video
- **Image hosting:** Cloudinary
- **i18n (web):** `next-intl`, message catalogs in `nesty-web/messages/`
- **Hosting:** Vercel (free tier currently) for both web apps
- **Repo management:** GitHub Projects board at github.com/users/GhofraneFarhaoui/projects/6

## Users and roles

- **Nesty staff** (in Nesty Base): owner, admin
- **Agency users** (in Nesty Web + Mobile Agency role): agency owner, agency agent
- **End users** (in Mobile): Seeker (primary), Partner (secondary — verification and trust role)

Role determination should always happen server-side via JWT claims or DB lookup, never trusted from the client. Any admin-capable action must be gated server-side AND written to an audit log in the same transaction.

## Current stage — this is critical context

Nesty is **pre-MVP, pre-revenue, pre-first-customer.** The platforms are functional but have not been used by real agencies yet. The founder is currently unable to do in-person outreach and is working from home on technical and marketing preparation.

The current priority order is:
1. Security and data-isolation audit (RLS, secrets, RBAC)
2. Seeded demo environment for sales calls
3. Product tour videos (founder on camera, French + Arabic, not motion graphics or AI avatars)
4. Landing page rewrite targeting Tunisian real estate agencies specifically
5. Arabic + RTL localization
6. Analytics instrumentation (PostHog) and error monitoring (Sentry)
7. Outreach to 10 identified agencies via WhatsApp/Facebook/email for pilot program

**Do not suggest:** new features, motion graphics, AI avatar tutorial characters, complex design systems, Discord communities, newsletters, dark mode, extensive test coverage beyond critical paths, exhaustive Storybook docs, or fundraising work. These are premature at this stage.

**Do suggest:** anything that reduces time-to-first-paying-customer, hardens security, improves the sales demo experience, or accelerates the founder's ability to close pilot agencies.

## Known gaps (verified, as of 2026-08-01)

These are open and known — do not re-report them as discoveries, and do not fix them unless asked:

- **No Arabic translations.** `nesty-web/messages/` contains only `en.json` and `fr.json`. AR + RTL is priority #5 and not started.
- **Supabase not linked locally.** No live DB connection; all schema/RLS work is static analysis of the migration SQL.
- **Schema is fragmented across three repos** (15 / 5 / 3 migrations) with no consolidated view.
- **PostHog and Sentry are not instrumented** (priority #6).
- **Two landing pages exist** — `nesty/landing/index.html` (static) and the landing inside `nesty-web`. Clarify which is canonical before editing either.

## Business model and pricing

**Founding Partner Program (first 10 agencies, current offer):**
- 99 TND/month for the first 3 months, then 199 TND/month
- No engagement, cancel anytime
- Free data export on exit
- In exchange: weekly 30-minute feedback call for the first 3 months

**Standard pricing (post-pilot, target):**
- Starter: 149 TND/month (solo agent, ~20 listings, 1 user)
- Agence: 299 TND/month (unlimited listings, up to 5 users) — the intended primary tier
- Pro: 599 TND/month (unlimited everything, priority support, custom domain)

**Financial baseline:**
- Gross margin target: ~95% (typical SaaS)
- Target ARPA: ~199 TND blended
- CAC ceiling: ~600 TND per agency (roughly 3x monthly price)
- Target LTV: 4,800+ TND per agency (24+ month average retention)
- Growth targets: 10 agencies by month 6, 30 by month 12, 100 by month 24

## Market and cultural context

- **Geography:** Tunisia first (Sousse → Tunis → Sfax), then expanding across North Africa
- **Languages:** French and Tunisian Arabic (Darija) are the working languages of real estate transactions. Modern Standard Arabic for formal documents. English is secondary.
- **RTL support is required** for Arabic UI. All Tailwind classes needing directional variants must use `rtl:` prefixes.
- **Buyer behavior:** Tunisian agency owners ask "how much?" in the first minute of the first meeting. Pricing must be communicated confidently and clearly, not dodged with "it depends." Negotiation is expected and cultural — build a small margin into any quoted price.
- **Preferred channels:** WhatsApp Business > Facebook Messenger > Instagram DM > Phone > Email. Email has ~3% response rate in this segment.

## Outreach pipeline

10 real estate agencies in the Sousse area have been identified for initial outreach (contact list stored separately). Approach: send in batches of 3, iterate on message based on response, keep last 4 in reserve. Every outreach should include a link to a 90-second personalized demo video by the founder in French (and eventually Arabic).

## Coding conventions and expectations

- **TypeScript strict mode** across all web repos
- **Server-side auth checks** on every mutation, no exceptions
- **Never expose the Supabase service_role key to any client-side code or mobile bundle** (on mobile, note `dart_defines` values are compiled into the bundle and are extractable — treat them as public)
- **Every user-facing string** goes through the translation layer (no hardcoded FR/EN/AR strings in components)
- **Every async operation** must have error handling and, in production paths, a Sentry capture
- **Every admin action** must produce an audit log entry in the same transaction
- **Every agency-scoped query** must derive agency_id from the authenticated user server-side, never trust client-supplied agency_id
- **Prefer server components** in Next.js unless interactivity is required
- **Images** must go through next/image with defined dimensions
- **Migrations** live in the repo that owns the feature, but assume every other repo sees the result

## Definition of done for any feature

A feature is not done until:
1. It works on all three apps if it touches shared data
2. It has RLS policies preventing cross-tenant access
3. It has at least one integration test on the critical path
4. It emits PostHog events for activation tracking
5. It has FR and AR translations (EN optional)
6. It handles the offline / no-network case gracefully on mobile
7. It has an entry in the changelog visible to the founder

## What you (Claude) should default to when uncertain

- **When in doubt about scope:** choose the narrower option. Small, shippable, reversible.
- **When in doubt about a feature:** ask whether this helps close a paying pilot agency in the next 60 days. If not, defer.
- **When in doubt about tech debt:** flag it, but do not fix unless it blocks Phase 1 goals.
- **When in doubt about pricing or business:** default to the numbers in this document; do not invent new pricing models.
- **When asked to "build X":** first ask which of the three apps X lives in, and whether X requires shared data model changes affecting the other two.
- **When suggesting external tools or libraries:** prefer free tiers, prefer tools with strong French/Arabic community support, prefer tools that work well on limited-bandwidth connections (Tunisian mobile networks are inconsistent).
- **When this doc conflicts with the code:** the code wins. Verify, then correct this file in the same session.

## Working preferences (how the founder wants sessions run)

- **Finish what is in flight before pivoting.** When a large new request arrives mid-task, do not silently context-switch — the founder has explicitly chosen to close out current work first even when the new request was higher-stakes. Ask, or default to finishing the current unit.
- **Run each audit phase in its own fresh session** so context does not dilute attention.
- **Static analysis over live connections** for anything Supabase, until the project is linked.

## Environment constraints (developer machine)

- **Windows 11 Pro. Smart App Control is ENABLED and enforced.** It blocks unsigned / not-yet-reputable native Windows executables outright. Confirmed 2026-07-31: Remotion's native Rust compositor (`remotion.exe`) failed with "spawn UNKNOWN" / "An application control policy has blocked this file" from both PowerShell and Git Bash.
- **Implication:** any freshly npm-installed native binary (bundled ffmpeg, image/video tooling, compilers) may hit the same wall. Prefer (a) WSL2 — Linux ELF binaries bypass Windows CI checks, this is the chosen workaround; (b) a cloud-executed path; or (c) flag to the founder. **Never propose disabling Smart App Control** — per Microsoft it cannot be re-enabled without a clean Windows reinstall.
- Browser-based / JS-only tool paths (e.g. Remotion Studio preview, which uses signed Chrome) are unaffected.

---

## Session log — decisions and outcomes

*Append the outcome of each significant session here so future sessions inherit the context.
Newest last. Keep entries to what changed and what was decided, not narrative.*

### 2026-07-31 — Pre-pilot audit plan defined, then deferred
A multi-phase security/quality audit plan was written for the whole platform, to run before
talking to agencies. **Outcome: not started.** The founder chose to finish the demo video first.
Scope constraint set: **static analysis only** — read `supabase/migrations` SQL in each repo,
no live Supabase CLI/DB connection.

Planned order, still the agreed sequence:
- **Phase 0** — a `CLAUDE.md` in each repo root. *(Partially done: platform-level file exists at the root as of 2026-08-01; per-repo files still missing.)*
- **Phase 1** (highest priority, before any agency contact):
  - 1.1 RLS inventory across all three apps — every table, RLS enabled?, every policy (name / command / USING / WITH CHECK / role). Flag tables without RLS, `USING (true)` policies, unvalidated INSERT ownership, and any `service_role` key usage outside server-only code (client/mobile leak = stop-everything severity).
  - 1.2 Secrets/env scan — hardcoded keys, `.env.example` vs actual `process.env.*` usage, `NEXT_PUBLIC_` vars holding sensitive data. Mobile is highest risk (bundled = extractable).
  - 1.3 Admin RBAC + audit trail — for each admin action (ban, delete listing, approve verification, restore access, change role): is the check server-side?, is it audit-logged?, same transaction?, can actor identity be forged?
- **Phase 2** — per-platform deep dives, **mobile first** (hardest to patch post-release): mobile (role source of truth, KYC/ID photo storage privacy, deep-link re-auth, offline/local-state reconciliation, push token scoping, 3D tour asset size limits, payment readiness) → base (pagination, query sanitization, analytics query cost, ban session invalidation) → web (Core Web Vitals, SEO/i18n incl. AR+RTL, multi-tenant `agency_id` scoping, image upload validation, reservation state machine).
- **Phase 3** (before pilot, not before demo) — test coverage, WCAG AA accessibility, i18n completeness, Sentry, CI (build + typecheck + lint on PR).
- **Phase 4 — explicitly deprioritized** — full e2e suites beyond critical paths, exhaustive design-system docs, sub-100ms perf tuning, complex internal analytics, fine-grained permission trees.

### 2026-07-31 — Demo video blocked by Smart App Control, WSL2 chosen
The Remotion render in `demo-video/` could not run locally: Smart App Control blocked the
unsigned native compositor binary. **Outcome:** WSL2 chosen as the workaround (low-cost,
reversible); WSL was being installed via elevated `wsl --install` + restart. Disabling Smart
App Control was rejected as too costly. See "Environment constraints" above.

### 2026-08-01 — This file created, verified, and corrected
Reviewed the platform context doc against the actual filesystem. **Outcome:**
- Renamed `claude.md.txt` → `CLAUDE.md` so it auto-loads as project context in every session
  (the `.txt` extension meant it was never being read automatically).
- **Corrected a load-bearing error:** the doc described mobile as "React Native (Expo assumed)"
  at a `nesty-mobile/` path. The app is **Flutter** at `nesty/`. Verified via `pubspec.yaml`,
  `lib/`, `.metadata`, `dart_defines.example.json`.
- Added: verified repo layout and dependency versions, the `tour3d` FastAPI service, Cloudinary,
  the three-way migration split (15 / 5 / 3), the missing-`ar.json` gap, the two-landing-page
  ambiguity, working preferences, environment constraints, and this session log.

### 2026-08-01 — Backlog board audited against the code (Done / In progress / Q/A)
Compared all 14 tickets on the GitHub Projects board (`GhofraneFarhaoui/projects/6`,
repo `nesty-web`, which is **public** — the REST API works unauthenticated) against the
implementation. The reservation module is strong (Postgres `EXCLUDE` constraint, soft-lock,
audit triggers, RLS); the gaps were at the edges.

**Fixed and verified** (tsc + lint + 62 unit tests + `next build`, both repos green):
- **Traveller catalog returned zero listings.** `getPublicListings`/`getListingFacets`
  filtered `status = 'active'`, but the lifecycle migration renamed `active` → `published`.
  Added `PUBLIC_VISIBLE_STATUSES` (both values) + a regression test.
- **#21** decline reason is now mandatory server-side *and* client-side (was optional in both).
- **#21** added the missing **Date** filter (stay-date window) through query → page → UI.
- **#15** "a published listing cannot be edited" is now enforced in the `persist()` server
  action, not only by the edit route's redirect (a server action is a public endpoint).
- **#12** host now gets a notification after listing submission.
- **#24** damage can no longer be reported before the stay starts.
- **#19** login now returns one generic translated error; it previously leaked
  account-existence and hardcoded English Supabase setup instructions onto the login page.
- **#24** built the missing Nesty Support incident queue in `nesty-base`
  (`/incidents` page + client + `/api/incidents/[id]` lifecycle route + nav + audit events).
  RLS already allowed super-admins; there was simply no UI.

**Known-open, deliberately not changed** (see the report for detail): #18 2FA is still in
Backlog although #19's flow depends on it; #19's "lock after N failed attempts" and
"log every sign-in" business rules are unimplemented; #23 cannot move a reservation to an
alternative listing; #12's "Brouillon after submit" wording conflicts with the `completed`
status the code uses; #14 blocks deletion on pending bookings too (stricter than the AC).

### 2026-08-01 — Mobile app resynchronised with the agency dashboard
The Flutter app had drifted badly from the web. Root cause in every case: the reservation and
listing-lifecycle migrations landed on the web side only, and mobile was never brought along.

**Shared contract added:** `nesty/lib/features/listings/domain/entities/listing_schema.dart`
mirrors `nesty-web/src/lib/listings/schema.ts` id-for-id (statuses, property types, amenities,
tags, pricing model, payment/cancellation policies, photo limits, Tunisia bounds, phone rule).
**Keep the two files in step — that is the whole point of it.**

Defects found and fixed:
- **Amenities didn't match.** Mobile wrote `'Wi-Fi'`, `'Bills included'`; the web expects
  `'wifi'`, `'hotWater'`. A listing created on a phone rendered blank amenities on the web.
- **Drafts were public.** The mobile feed queried `listings` with no status filter, so a host's
  unfinished drafts reached seekers. Now filtered to `publicVisibleStatuses`.
- **`rejected` and `expired` didn't exist in the mobile enum** and fell through to `pending`, so
  a traveller whose request was declined saw "Pending" forever. Both added, plus read-time
  soft-lock expiry (`effectiveStatus`) matching the web's 15-minute sweep.
- **The decline reason was never shown to the traveller** — the web makes it mandatory precisely
  so it can be. Now surfaced on the trip card, along with the booking reference and the 48 h
  countdown.
- **Declining on mobile asked for no reason at all** while the dashboard required one. Added a
  reason sheet; the store writes `cancellation_reason`. Pending → `rejected`, confirmed →
  `cancelled`, same as the web.
- **Manual `availability_blocks` were invisible to mobile**, so a seeker could request blocked
  dates and hit a raw Postgres exclusion error. Blocks are loaded, merged into a shared
  `DayAvailability` calendar (confirmed > blocked > pending, the web's precedence), and the
  booking flow pre-checks the range.
- **Wizard fields were absent from the mobile model** (property type, capacity, district, contact
  phone, house rules, pricing, booking conditions). Added to `Property`/`PropertyModel`, written
  by the create form, and shown on the details page as a "Good to know" block.
- **Prices lied.** Mobile hard-coded "/ month" and divided by 30, so a nightly-priced listing
  showed a thirtieth of its rate. Now driven by the host's own `pricing.model`.

**Not verified by a compiler:** there is no Flutter/Dart SDK on this machine. Changes were
checked by reading, brace/paren balance, and symbol-existence greps — `flutter analyze` still
needs to run before release.

### 2026-08-01 — Cross-platform review, realtime, landing corrections
**Found a stop-everything bug.** `public.notifications` was created by the *mobile* migration
(`20260716240000`) with `title text not null` and no `payload` column. The dashboard's
`20260723120000_reservation_module.sql` then declared the same table with
`create table if not exists` — a no-op — so `payload` and `read_at` were never added. Its
`reservations_log_event()` trigger inserts `payload` and never sets `title`, and it is
`AFTER INSERT OR UPDATE ... FOR EACH ROW` on `reservations`, so the exception rolls back the
statement: **every booking request and every accept/decline would fail.** Mobile also had its own
two notification triggers on the same table, so fixing only the columns would have doubled every
alert. Reconciled in `20260801120000_reconcile_notifications_and_realtime.sql`: widened the table
to a superset both apps read, made `title` nullable, kept `read` ⇄ `read_at` in sync via trigger,
consolidated onto one trigger that writes both shapes, and retired mobile's pair.
**This migration has not been applied — no Supabase project is linked.**

**Realtime.** Mobile already subscribed (notifications, verification); the web had *no*
subscriptions at all, and `reservations` wasn't even on the publication. Added `reservations`,
`availability_blocks`, `reservation_incidents`, `listings` to `supabase_realtime` plus
`replica identity full` on reservations; added `RealtimeRefresh` to the dashboard layout
(debounced `router.refresh()`, scoped by `host_id`); added a reservations/blocks subscription to
mobile's `ReservationsStore`.

**Landing copy corrected — it was claiming things that don't exist.** "Requests with SLA timers…
re-routes after 30 minutes", "Median response cut from 4h to 11min", "Reviewed in under 24h, most
within 4", and a four-tier role model (owner/agent/manager/viewer) were all invented. For a
pre-revenue product with zero customers those are unbackable if an agency probes them. Replaced
with what actually ships: the real 48 h hold and auto-expiry, mandatory decline reasons, manual
date blocking, DB-enforced overlap prevention, and the new incident lifecycle. FR + EN both.

**Ticket #6 was marked Done on the board but had never been done** — all three strings it asks to
remove were still live. Founder chose "headings only" (keep the sections, drop the repeated
lines). Now actually done: `pillars.eyebrow`, `product.title1/2` and `features.title1/2` removed
from both locales and from `pillars.tsx` / `product.tsx` / `features.tsx`, with the surrounding
spacing re-balanced so nothing is left hanging (product's lead is promoted to display scale,
features' grid tightens from `mt-14` to `mt-8`). **The board still shows #6 as Done from before —
worth re-checking the other Done tickets the same way.**

### 2026-08-01 — Action feedback on mobile, and the first real mobile tests
**The app was lying to agencies.** `ReservationTile` fired
`AppFeedback.success(context, 'Reservation confirmed')` in the button's `onTap`, before the write,
while `ReservationsStore.setStatus` / `remove` ended in `catch (_) {}` and returned `void`. So a
failed confirm — an overlap the exclusion constraint refused, a dropped connection — showed a
success snackbar and the agency believed a booking was accepted that wasn't. Deleting a listing
was the same shape, plus no confirmation dialog at all on a permanent action.

Fixed: the stores now return `Future<String?>` (null = wrote, otherwise a sentence), matching the
convention `add()` already used. The tile is stateful, awaits the result, disables every button
and shows a spinner while in flight, then reports success or the actual error. Listing deletion
asks first, and warns differently when the place has upcoming bookings.

`lib/core/error/db_error_messages.dart` translates Postgres text into sentences — the exclusion
constraint, the block-guard trigger, a missing migration, an RLS refusal. Raw messages like
`conflicting key value violates exclusion constraint "reservations_no_active_overlap"` were
previously shown to users verbatim. **Mirrors `describe()` in the web's
`actions/reservations.ts` — keep the two in step.**

Also fixed: the mobile publish path did `..['status'] = 'active'`, overriding the wizard's own
`published` and writing every phone-created listing in the pre-migration vocabulary.

**Mobile now has real tests** — `test/reservation_logic_test.dart` and
`test/listing_schema_test.dart` (~60 assertions) pin every regression from this session: the
`rejected`/`expired` parsing bug, soft-lock expiry, checkout-day exclusivity, calendar
precedence, the amenity vocabulary, status round-tripping, `PropertyModel` round-trip including
half-migrated rows, and that `describeDbError` never echoes raw DB text. **They have not been
run — still no Flutter SDK. `flutter test` is the first thing to do when one is available.**

### 2026-08-02 — Actually ran both web apps
Started `nesty-web` (:3000) and `nesty-base` (:3100) and hit every route. Neither repo has a
`.env.local`, which is what exposed the two bugs below — *how* an app fails on missing config is
a production concern, not just a local annoyance.

**`nesty-base`: attempted fix, REVERTED — do not retry this approach.**
Locally the console 500s on every authenticated route when env vars are missing, because
`createServerSupabase()` passes `process.env.X!` into `createServerClient`, which throws on an
empty string. The attempted fix added `lib/supabase/env.ts` with an `isSupabaseConfigured`
predicate and made `requireAdmin()` redirect to `/login?error=supabase_missing`.

**It locked staff out of production.** `nesty-base.vercel.app` started showing "This deployment
has no Supabase credentials" even though production is configured, so nobody could sign in.
Reverted on 2026-08-02 — `auth.ts`, `supabase/server.ts`, `supabase/client.ts` and the login
error map are back to their original form, and `env.ts` is deleted.

**The lesson, which matters more than the bug:** the guard sat on the *authentication* path and
**failed closed**. Any false negative in the predicate — a URL stored without its `https://`
prefix, a differently-named key variable, a `NEXT_PUBLIC_*` value not inlined into the build Vercel
actually served — becomes a total lockout of the admin console. The original 500 was noisy and
ugly, but it failed *loudly* and only when genuinely unconfigured. Never gate sign-in on a
heuristic about environment variables.

If the local 500s are worth addressing later, the safe shape is **diagnostic only**: log a clear
server-side warning naming the missing variables, and let the client throw as it always did. No
redirect, no gate, no behaviour change for a correctly configured deployment.

*(The equivalent guards in `nesty-web` are on read paths and the login **form action**, not on
session resolution, and were verified against a running server. They are unaffected by this
revert — but the same caution applies if anyone extends them.)*
- **`nesty-web` threw from every unguarded `createClient()` call site.** It has ~30 of them and
  only 3 checked `isSupabaseConfigured` first. The first pass guarded `getDashboardData()` alone,
  which was not enough — clicking **Sign in** on `/login` reached `signIn()` and produced
  `POST /login 500`, because `/login` renders without credentials and is therefore the one action
  reachable in that state.
  Now guarded: all **11** exported reads in `queries.ts`, both in `tickets.ts`, and `signIn`
  (returns a translated `login.errors.notConfigured`; FR + EN added). The remaining action call
  sites all require a signed-in user, which is unreachable without config, so guarding them would
  be dead code.
  **Verified: `POST /login` 500 → 200 showing "Sign-in isn't configured on this environment yet",
  all ten `/dashboard/*` routes 200, no throws in the server log after the fix.**

**Cheap regression test worth repeating:** boot both apps with no `.env.local` and click through.
Anything that 500s is a route that will 500 in production the day a Vercel variable is rotated or
a preview environment is created without them. This is Phase 1.2 (secrets/env) territory.

**Found, NOT fixed — decide before the landing rewrite (priority #4):**
The landing was refactored into a Seeker/Host space switch (`page.tsx` renders only `<HostSpace>`
or `<SeekerSpace>`), and **six section components were orphaned in the process**: `Pillars`,
`Product`, `Features`, `HowItWorks`, `Faq`, `Showcase`. They are exported and still maintained
but imported by nothing.

Consequences worth knowing:
- **`page.tsx` still emits `FAQPage` JSON-LD** built from `faq.items`, for an FAQ section that no
  longer renders. Google requires FAQ markup to match content visible on the page — this is an
  SEO liability, not just dead weight. `faq.tsx`'s own comment says the markup and visible copy
  are meant to agree; they no longer do.
- **`site.nav` is dead config** pointing at `/#product`, `/#features`, `/#how`, `/#faq` — none of
  which exist. Nothing renders it today (the header deliberately has no nav links), so it is not
  a visible broken link, but it will become one the moment someone wires up a footer nav.
- **Ticket #6 was moot.** The three sections it asked to remove had already stopped rendering. The
  heading edits made on 2026-08-01 were to unmounted components — harmless, but the ticket's real
  answer was "already gone".

### 2026-08-30 — Unbackable claims removed from the landing before the launch posts
Picked up the launch-sprint thread (post 02 fires Mon 31 Aug). The handoff note inside
`posts/nesty_platform_project.zip` flagged "`demandes avec SLA` still live, third time flagged" —
it was, and it was not the only one.

**Fixed in `nesty-web`, verified (tsc + lint + 62 tests + `next build`, all green):**
- **`host.agency.body` / `.points` claimed three features that do not exist** — "team roles",
  "bulk listings", "requests with SLAs". There is no invite/team UI, no bulk-listing UI and no SLA
  anywhere in `src/app/dashboard/`. Rewritten in both locales to what ships: one shared calendar,
  accept/decline on requests, incidents + support. This block *renders* (`host-space.tsx:126`).
- **Three fabricated 5-star `Review` nodes were emitted as JSON-LD** from `page.tsx` — invented
  people at invented agencies, `ratingValue: 5`. Fabricated review markup violates Google's
  review-snippet policy and is exactly the "checked in one phone call" risk `posts/README.md`
  warns about. Removed.
- **`FAQPage` JSON-LD was still emitted for an FAQ section that no longer renders** (the orphan
  problem logged 2026-08-02). Google requires FAQ markup to match visible content. Removed, along
  with the now-unused `getTranslations` import.
- **The whole `Voice` testimonial section was deleted** (founder's call): `voice.tsx`, the
  `<Voice />` render in `seeker-space.tsx`, `TESTIMONIALS` in `showcase.ts`, and the `voice` block
  in both locales. Its heading asserted *"Three people who'd let us call them"* about people who
  do not exist.

**Correction to the 2026-08-02 entry — it is wrong about which components are orphaned.**
That entry lists `Product`, `Features`, `Pillars`, `HowItWorks`, `Faq`, `Showcase` as orphaned and
implies the landing is only `HostSpace`/`SeekerSpace`. But those two *space* components import
sections **relatively** (`from "../voice"`), so a grep for `landing/<name>` misses them and
under-reports what is live. `Voice` was rendered at `seeker-space.tsx:255` the whole time.
**Before calling any landing component dead, grep the relative form too.**

Still orphaned and left alone (they ship nothing): `product.tsx`, `faq.tsx`, and the `AGENCIES`
mock list in `showcase.ts` — the last one is captioned "Partner agencies onboarding during launch
phases" with listing counts, so if anything ever renders it, it needs the same treatment.

---

### 2026-10-23 — Full platform readiness review

Production Web and Mobile Web deployments completed after full local checks: Nesty Web passed typecheck, lint, build, and 65 tests; Nesty Base passed typecheck, lint, and build; Flutter passed analyze, 36 tests, and release web build. Public production HTTP checks passed. The catalog has 31 published non-demo listings attributed to the active Achref Agency account; all have a title, city, valid positive price, and image. Full findings, Supabase advisor items, availability gaps, analytics counts, and test boundaries are documented in `docs/PLATFORM_READINESS_REVIEW_2026-10-23.md`.

Known sign-off gaps: the 31 listings have no `available_from` values and the database has no manual availability blocks (two active reservations exist); agency calendar confirmation remains required. Supabase leaked-password protection is disabled and the sanitized public calendar view is still flagged by the security advisor. Payment processing, external error monitoring, and authenticated browser E2E sign-off are not complete. The mobile account-deletion flow is a support request; no hard-delete RPC was applied.

Last updated: 2026-10-23
Maintainer: Achref Ben Yaagoub
