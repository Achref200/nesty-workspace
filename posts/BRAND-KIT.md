# Nesty — Social brand kit

Everything here is pulled from the shipped product, not invented for marketing.
If a post and the product disagree, the product wins and this file gets corrected.

---

## Colour — strict monochrome

The product's design tokens (`nesty-web/tailwind.config.ts`) are a deliberate
black/white/grey system: *"Ink is the only accent; greys carry all hierarchy."*

| Token | Hex | Use in social |
|---|---|---|
| `ink` | `#141414` | Text, and the "loud" slide backgrounds |
| `ink-strong` | `#0B0B0B` | Deep backgrounds |
| `paper` | `#FAFAF9` | Default slide background |
| `card` | `#FFFFFF` | Cards on paper |
| `fill` | `#F1F1F0` | Chips, quiet blocks |
| `separator` | `#E6E6E4` | Hairlines |
| `muted` | `#7A7A78` | Secondary text |
| `muted-soft` | `#B4B4B1` | Slide numbers, captions |
| `danger` | `#B23A34` | **Never on social.** Product-only. |

**Zero colour is the strategy, not a limitation.** Scroll a Tunisian real-estate feed:
gradients, orange "PROMO" starbursts, phone numbers in outlined text, five fonts per
image. Pure black-and-white editorial layout stops the thumb precisely because
everything around it is shouting. It also signals *software company*, not *broker* —
which is exactly the repositioning we need with agency owners.

Hold the line on this. The first instinct on post 4 will be "let's add a colour."
Don't.

## Type

| Role | Font | Where |
|---|---|---|
| Display | **Outfit** (600/700), tight tracking `-0.03em` | Headlines |
| Body / UI | **Plus Jakarta Sans** (400/500/600) | Everything else |
| Micro-label | Plus Jakarta Sans 600, `0.14em`, uppercase, 13–15px | Eyebrows, tags |

Both are the fonts the site actually loads (`next/font/google`, `layout.tsx`), so
posts and site are visually the same product. Both are free on Google Fonts.

**Display type on a carousel should be enormous** — 96–150px at 1080 wide. Social is
read at thumbnail size. If it's legible in Chrome at 100%, it's too small.

## Logo

"The Nested Curves" — three concentric arcs, open at the top, plus the wordmark.
Source: `nesty-web/public/nesty-logo.svg`. Inline path data:

```svg
<svg viewBox="0 0 200 240" fill="none">
  <path d="M 20 120 C 20 45, 55 20, 100 20 C 145 20, 180 45, 180 120"
        stroke="#141414" stroke-width="8"   stroke-linecap="round" fill="none"/>
  <path d="M 42 125 C 42 62, 65 42, 100 42 C 135 42, 158 62, 158 125"
        stroke="#141414" stroke-width="6.5" stroke-linecap="round" fill="none"/>
  <path d="M 62 130 C 62 80, 78 62, 100 62 C 122 62, 138 80, 138 130"
        stroke="#141414" stroke-width="5"   stroke-linecap="round" fill="none"/>
</svg>
```

Swap `stroke` to `#FAFAF9` on dark slides. Never recolour it to anything else, never
add a container shape, never rotate it.

The arcs read as a nest and as a roof at the same time. Use that in copy sparingly —
once per campaign, not once per post.

---

## Voice

Nesty sounds like **a working tool describing itself plainly.** Short declaratives.
Concrete nouns. No adjectives doing the work a fact could do.

The best line already on the site is the standard to hit:

> *« Un calendrier qui ne ment jamais. »*

That is the whole voice: a promise, mechanically true, six words.

**Do**
- Name the mechanism. "Deux réservations ne peuvent pas se chevaucher" beats
  "gestion optimisée".
- Use real numbers: 8 photos, 48 heures, 10 agences, 99 TND.
- Speak to one agency owner, singular. "Vous", never "les professionnels du secteur".
- Let a sentence end early.

**Don't**
- ❌ "Révolutionner l'immobilier tunisien" — every deck says this
- ❌ "Solution innovante / digitalisation / synergie"
- ❌ Emoji chains 🔥🚀💯 — one emoji max per caption, or none
- ❌ Exclamation marks in body copy
- ❌ Any customer count, testimonial, or logo wall until they are real

## Claims we are allowed to make

Verified against the shipped code and the fact-checked landing copy:

- ✅ Address checked against a real map, photos scanned for stock images, owner ID
  manually verified — **before** a listing publishes
- ✅ 8 photos of a room → a 360° tour, opens in a link, **no app, no headset, no
  plugin** (Tour3D, in-house engine)
- ✅ Nightly, monthly and yearly on **one** calendar
- ✅ Double-booking prevented **in the database**, not by a reminder
- ✅ 48-hour hold on a request, then it auto-expires
- ✅ A decline **must** carry a reason — the seeker sees it
- ✅ Manual date blocking
- ✅ A booking on mobile appears in the agency workspace immediately (realtime)
- ✅ Pay on arrival **or** online
- ✅ Three surfaces: seeker app, agency workspace, Nesty support console

## Claims that are forbidden

- ❌ Any number of agencies, users, listings, or bookings
- ❌ Any SLA, response-time or auto-routing claim *(these were invented and removed
  from the landing once already — do not let them back in via a caption)*
- ❌ "Trusted by", "leader", "N°1", "la plateforme préférée des agences"
- ❌ Anything about an Arabic app UI (not built yet)
- ❌ Self-serve agency signup (access is opened manually, agency by agency)

---

## Reel grammar

Same look every time, so three posts read as one brand.

- **Vertical 1080×1920**, phone at chest height, lens at eye level.
- **One window of daylight**, founder facing it. No ring light — it reads as an ad.
- **Plain wall behind.** No desk clutter, no visible logo of another company.
- **Cut every 2–3 seconds.** No shot longer than 4s except the closing line.
- **Subtitles burned in**, FR, bottom third, Plus Jakarta Sans 600, white on a
  black pill. Never the platform's auto-caption styling — it dates the video.
- **Screen recordings**: real device, real data from the demo seed. Never a mockup
  frame, never a hand-drawn wireframe.
- **Audio**: founder's voice is the track. Music at 8–12% under it, or none. If a
  trending sound is used, keep it under 15% — the message is the voice.
- **Last frame holds 1.5s** on the wordmark + `nesty-tn.vercel.app`, silent.

## File naming

`YYYY-MM-DD_post-NN_channel_format.ext` —
e.g. `2026-08-27_post-01_instagram_reel.mp4`

Keep the exported PNGs and MP4s next to the post folder they came from.
