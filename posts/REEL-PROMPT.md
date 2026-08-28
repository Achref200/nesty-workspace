# Nesty — Reel prompt for AI video generators

30–32s vertical product reel. Every claim below is pulled from the shipped
product (`nesty-web/messages/en.json`, `src/lib/site.ts`, `tailwind.config.ts`).
Nothing here is invented for marketing. If a generator "improves" the copy,
reject the take.

---

## A. MASTER PROMPT — paste into a script-to-video tool

*(InVideo AI, Revid.ai, Higgsfield, Pika Scenes, Canva Magic Studio)*

```
Create a 30-second vertical video (9:16, 1080x1920, 30fps) presenting a SaaS
product called Nesty — a rental platform for Tunisia.

TONE: premium, editorial, restrained. Think Apple product page or a Swiss design
magazine — not a real-estate ad. Calm confidence. No hype, no hard sell.

STRICT ART DIRECTION — do not deviate:
- Colour: pure monochrome ONLY. Background #FAFAF9 (warm paper) or #0B0B0B
  (deep ink). Text #141414 on paper, #FAFAF9 on ink. Hairlines #E6E6E4,
  secondary text #7A7A78. ZERO colour anywhere — no gradients, no accent hue,
  no colour grading, no orange/blue/gold. The absence of colour is the brand.
- Typography: headlines in Outfit SemiBold/Bold, letter-spacing -0.03em, very
  large (fills 60-70% of frame width). Small labels in Plus Jakarta Sans
  SemiBold, uppercase, letter-spacing 0.14em, tiny. Two fonts total, never more.
- Motion: slow and expensive. Text fades and rises 20px over 600ms with a soft
  ease-out. Imagery moves with a 4-6% push-in over the whole shot. Cuts are hard
  and on-beat. NO zoom bursts, NO whip pans, NO shake, NO parallax stacks,
  NO kinetic-typography bouncing, NO glitch, NO light leaks, NO lens flare.
- Imagery: whitewashed Tunisian/Mediterranean architecture — blue-and-white
  doors, arched medina windows, sea-view terraces, quiet interiors with linen
  and clay. Shot in natural daylight, desaturated to near-monochrome.
  NO people looking at the camera, NO handshakes, NO stock-photo smiling agents,
  NO drone-over-a-city cliche, NO keys-in-hand shot.
- Audio: one ambient piano/analogue-synth bed, no lyrics, no vocal chops,
  no whoosh transitions. Gentle build. Silence for the last 1.5s except the
  final line.
- Text on screen must be spelled EXACTLY as given. Do not paraphrase, do not
  translate, do not add words, do not add emoji or hashtags.

SCRIPT — 8 shots, in this order:

SHOT 1 (0.0-3.0s) — Deep ink background #0B0B0B, empty. Three concentric white
arcs (a nest shape, open at the top) draw themselves on from left to right, then
the wordmark "nesty" fades in beneath in lowercase Outfit.
ON SCREEN: nesty
VOICEOVER: "Louer en Tunisie n'a jamais ete simple."

SHOT 2 (3.0-7.0s) — Cut to paper #FAFAF9. Huge black headline, centred, two
lines. No imagery.
ON SCREEN: Un marche record,
           encore reserve sur Facebook.
VOICEOVER: "Un marche touristique record. Et des reservations encore gerees sur
Facebook et WhatsApp."

SHOT 3 (7.0-11.5s) — Whitewashed villa with a blue door, slow push-in. A small
white card slides up over the lower third with a hairline border and a tiny
uppercase label.
ON SCREEN: label "VERIFIE" / headline "Chaque logement est verifie par notre equipe."
VOICEOVER: "Chaque logement est verifie par notre equipe avant publication."

SHOT 4 (11.5-16.0s) — Interior of a sunlit apartment. A thin white wireframe
outline traces the walls and doorway, as if a 3D scan is being built, then
dissolves.
ON SCREEN: label "VISITE 3D" / headline "Visitez en 3D avant de vous deplacer."
VOICEOVER: "Vos clients visitent le bien en 3D, avant meme de se deplacer."

SHOT 5 (16.0-20.5s) — Cut to ink #0B0B0B. A clean minimal calendar grid draws
itself in thin white lines; two blocks fill solid white; one attempted overlap
is refused and slides away.
ON SCREEN: label "CALENDRIER" / headline "Un seul calendrier. Jamais de double reservation."
VOICEOVER: "Un seul calendrier honnete, partage. Jamais de double reservation."

SHOT 6 (20.5-24.5s) — Paper background. Terrace with a sea view, very soft.
Two short lines of text, one under the other, separated by a hairline rule.
ON SCREEN: A la nuit ou a la saison.
           Paiement a l'arrivee ou en ligne.
VOICEOVER: "A la nuit ou a la saison. Paiement a l'arrivee, ou en ligne."

SHOT 7 (24.5-28.5s) — A laptop on a plain desk, screen showing a monochrome
dashboard with a listings table and a calendar. Slow push-in on the screen.
ON SCREEN: label "POUR LES AGENCES" / headline "Tout votre portefeuille, dans un seul espace."
VOICEOVER: "Et pour votre agence, un espace professionnel qui gere tout votre
portefeuille."

SHOT 8 (28.5-32.0s) — Cut to ink #0B0B0B. The three arcs and the wordmark,
centred and small. One line beneath, and a hairline above the last line.
ON SCREEN: nesty
           Demandez votre acces agence
           nesty-tn.vercel.app
VOICEOVER: "Nesty. Demandez votre acces agence."
```

> The prompt block deliberately drops accents so that generators that render
> their own captions cannot mangle them. **The real accented copy is in section
> C** — use that when you add the text yourself in an editor, which is the
> recommended path.

---

## B. SHOT-BY-SHOT PROMPTS — for clip generators

*(Sora, Veo, Kling, Runway — these take one scene at a time; generate 8 clips,
then assemble and add the text in the edit, since these models render text badly)*

Prefix every one of the 8 prompts with this block:

```
Vertical 9:16, 1080x1920, cinematic, shot on 35mm, shallow depth of field,
natural daylight only, desaturated to near-monochrome (paper white #FAFAF9,
ink black #141414, no colour cast). Slow 5% push-in, locked-off otherwise.
Calm, editorial, premium. No people facing camera, no text, no logos,
no captions, no watermark, no lens flare, no camera shake.
```

| # | Clip prompt | Length |
|---|---|---|
| 1 | Pure black void, a single soft rim of light along the top edge. Nothing else. | 3s |
| 2 | An empty warm-white plaster wall, raking morning light, subtle hand-troweled texture. | 4s |
| 3 | A whitewashed Tunisian villa facade with a studded blue door and a bougainvillea shadow, Sidi Bou Saïd, morning. | 4.5s |
| 4 | Interior of a sunlit Mediterranean apartment, a linen curtain breathing, an arched doorway leading to another empty room. | 4.5s |
| 5 | Pure black void with a faint horizontal light gradient, abstract, empty. | 4.5s |
| 6 | A terrace overlooking the Mediterranean at midday, white balustrade, two empty chairs, sea haze. | 4s |
| 7 | A laptop, a closed notebook and a glass of water on a pale desk in a quiet office, window light from the left. | 4s |
| 8 | Pure black void, absolute stillness. | 3.5s |

**Then in the editor:** overlay the on-screen text from section C, in Outfit
(headlines) and Plus Jakarta Sans (labels), with the fade-and-rise motion
described in section A. Never let the generator draw the text.

---

## C. On-screen text + voiceover — the accented master copy

Record the VO yourself — the plan is founder-voiced, not a synthetic narrator.
Read it slowly; there is room for ~85 words in 32s.

| Shot | On screen | Voiceover (FR) |
|---|---|---|
| 1 | `nesty` | Louer en Tunisie n'a jamais été simple. |
| 2 | **Un marché record, encore réservé sur Facebook.** | Un marché touristique record. Et des réservations encore gérées sur Facebook et WhatsApp. |
| 3 | `VÉRIFIÉ` — **Chaque logement est vérifié par notre équipe.** | Chaque logement est vérifié par notre équipe avant publication. |
| 4 | `VISITE 3D` — **Visitez en 3D avant de vous déplacer.** | Vos clients visitent le bien en 3D, avant même de se déplacer. |
| 5 | `CALENDRIER` — **Un seul calendrier. Jamais de double réservation.** | Un seul calendrier honnête, partagé. Jamais de double réservation. |
| 6 | **À la nuit ou à la saison. Paiement à l'arrivée ou en ligne.** | À la nuit ou à la saison. Paiement à l'arrivée, ou en ligne. |
| 7 | `POUR LES AGENCES` — **Tout votre portefeuille, dans un seul espace.** | Et pour votre agence, un espace professionnel qui gère tout votre portefeuille. |
| 8 | `nesty` / Demandez votre accès agence / nesty-tn.vercel.app | Nesty. Demandez votre accès agence. |

**English voiceover**, for the same cut if a second version is needed:

> Renting in Tunisia has never been simple.
> A record tourism market — still booked on Facebook.
> Every home is verified by our team before it goes live.
> Your clients tour it in 3D, before they ever travel.
> One honest calendar. No double bookings, ever.
> By the night or by the season. Pay on arrival, or online.
> And for your agency, one professional workspace for the whole portfolio.
> Nesty. Request your agency access.

---

## D. Where each line comes from

| Reel line | Source in the product |
|---|---|
| "Un marché record, encore réservé sur Facebook" | `numbers.title1/2` |
| "Chaque logement est vérifié par notre équipe" | `seeker.benefits[0]` |
| "Visitez en 3D" | `seeker.benefits[1]`, backed by `nesty/services/tour3d` |
| "Jamais de double réservation" | `seeker.benefits[3]` / `host.benefits[2]`, DB-enforced by the `EXCLUDE` constraint |
| "À la nuit ou à la saison / paiement à l'arrivée ou en ligne" | `seeker.benefits[2]`, `hero.trustLine` |
| "Tout votre portefeuille, dans un seul espace" | `host.agency.title/body` |
| "Demandez votre accès agence" | `cta.requestAccess` |

---

## E. Guardrails — what must NOT enter the video

These were removed from the landing on 2026-08-01 for being unbackable, and must
not come back through a video script:

- No SLA timers, no "re-routes after 30 minutes", no response-time figures.
- No "median response cut from 4h to 11min" or any before/after metric.
- No "reviewed in under 24h".
- No customer count, no revenue, no testimonial — there are no customers yet.
- No four-tier role model (owner/agent/manager/viewer).
- No App Store / Google Play badges — the app is `coming soon` in the product copy.
- No colour. Not one accent. `danger #B23A34` is product-only, never social.
