# LinkedIn page — audit and proposed rewrite

**Status: DRAFT. Nothing has been applied.** Approve and I'll make the changes.

Page: `linkedin.com/company/nestytn` · id `106134696` · 58 followers
Audited: 25 Aug 2026

---

## The number that matters

| Last 7 days | |
|---|---|
| Search appearances | **130** |
| Page visitors | **2** |
| New followers | 1 |
| Post impressions | 14 |

**130 people encountered Nesty in LinkedIn search and 2 clicked through.** That is
roughly a 1.5% conversion, and it is the cheapest problem on this list to fix.
The demand already exists — the page is throwing it away.

This is worth more than the three posts. The posts create new attention; this
fixes the leak that attention is draining out of.

---

## What is live now, and what's wrong with it

### 1. Tagline — `Rent smarter.`

Uses **13 of 120 available characters.**

The tagline is the line shown under your name in search results, and it is
weighted heavily in LinkedIn's search matching. "Rent smarter." contains none of
the words a Tunisian agency owner would ever type — not *immobilier*, not
*agence*, not *Tunisie*, not *logiciel*, not *gestion locative*.

It is also ambiguous about who you serve. Someone reading it can't tell whether
Nesty is for renters or for agencies.

**This single field is most of the 130 → 2 problem.**

### 2. Banner — reads "For Tunisia · Coming Soon"

The banner image says **Coming Soon** while three products are live. Anyone who
does reach the page is told, by your own artwork, that there is nothing to use
yet.

### 3. Overview — 694 characters of vision, zero mechanism

Currently:

> "Nesty is redefining how people rent… Built with a human-first philosophy…
> intelligent digital tools that simplify every step… We're not just building
> another rental marketplace. We're building the future of trusted renting in
> Tunisia."

Three problems:

- **No concrete claim survives it.** "Intelligent digital tools" describes every
  software company ever founded. Nothing here says *one calendar*, *360° tours
  from eight photos*, or *listings verified before publication* — the things that
  are actually true and actually unusual.
- **It's in English.** The buyers are French-speaking Tunisian agency owners.
- **It ends on a manifesto, not an action.** No website, no invitation, nothing
  to do next.

Future-tense vision copy also reads as pre-launch, which reinforces the banner.

### 4. Industry — `IT Services and IT Consulting`

Wrong, and it costs distribution. LinkedIn uses industry to decide who sees the
page in recommendations and search. Agencies searching real-estate software are
not browsing IT consultancies.

**Change to `Real Estate`** (or `Software Development` if you'd rather signal
product company — but Real Estate puts you in front of the buyer, which matters
more right now).

### 5. Website URL field — appears empty

Verify this. One URL field holds `https://nesty-tn.vercel.app`, a second reads
empty. If the public **Website** field is blank, the page has no outbound link at
all, which would explain part of the 2-visitor number by itself.

Also: add a **custom button** → `Visit website` → `https://nesty-tn.vercel.app`.

---

## Proposed replacements

### Tagline (100 / 120 chars)

```
Logiciel de gestion pour agences immobilières en Tunisie · Annonces, calendrier unique et visites 3D
```

Every high-intent keyword is present — *logiciel*, *gestion*, *agences
immobilières*, *Tunisie* — and it names the buyer in the first four words.

**Alternative**, if you prefer the platform framing over the software framing:

```
La plateforme de location tunisienne · Pour les agences immobilières et ceux qui cherchent un logement
```

I'd take the first. It's the one that gets found.

### Overview — French first, English second

```
Nesty est la plateforme de location conçue pour les agences immobilières
tunisiennes.

Une agence gère aujourd'hui son portefeuille sur trois outils qui ne se parlent
pas : un cahier ou un tableur pour les disponibilités, WhatsApp pour les
demandes, Facebook pour les annonces. Nesty réunit les trois.

Ce qui est en ligne :

• Un espace de travail web où chaque bien vit sur un seul tableau. Courte durée,
  longue durée et baux à l'année partagent le même calendrier — et deux
  réservations ne peuvent pas se chevaucher, c'est garanti au niveau de la base
  de données.
• Une application mobile pour les locataires : recherche par quartier, visite 3D,
  demande de réservation. Une demande faite sur téléphone apparaît dans l'espace
  agence à la seconde.
• Des visites à 360° générées à partir de huit photos d'une pièce, prises au
  téléphone. Sans casque, sans plugin, rien à installer pour le locataire.
• Une vérification avant publication : adresse confrontée à une carte, photos
  analysées, pièce d'identité du propriétaire contrôlée manuellement.

Nous ouvrons l'accès agence par agence, en commençant par la région de Sousse.

Vous gérez une agence immobilière en Tunisie ? Écrivez-nous — nous configurons
votre espace, importons votre inventaire et transformons vos photos existantes en
visites 3D.

nesty-tn.vercel.app

—

Nesty is the rental platform built for Tunisian real estate agencies. One
workspace where every property lives on a single dashboard — nightly stays,
monthly rentals and year-long leases sharing one calendar, with overlapping
bookings prevented at the database level. Listings are verified before they
publish, and our in-house Tour3D engine turns eight phone photos of a room into
a 360° walkthrough that opens in a link — no headset, no plugin, no app for the
renter.

Built in Tunisia, for Tunisia.
```

Every claim in there is checked against the shipped product and the
already-fact-checked landing copy. No customer counts, no SLA claims, no
"leader" — see `BRAND-KIT.md` for the forbidden list.

### Banner

Replace with anything that does not say "Coming Soon". Simplest version that
works: the nested-arc logo on ink `#0B0B0B`, with

```
La plateforme de location tunisienne
```

I can generate this as a 1128×191 PNG from the same HTML pipeline that produced
the carousels — say the word.

### Also worth doing while you're in there

- **Industry** → `Real Estate`
- **Custom button** → `Visit website` → `https://nesty-tn.vercel.app`
- **Location** → add Sousse, so you appear in local searches
- **Languages** → add French as a page language; the LinkedIn page currently
  presents entirely in English to a French-speaking market

---

## Order of operations

1. Tagline *(biggest single win — do it even if you do nothing else)*
2. Industry → Real Estate
3. Overview
4. Banner
5. Button + location + languages

Steps 1–3 take about twenty minutes and are, per the numbers above, the highest
leverage twenty minutes available before Friday.

---

## One thing NOT to change

**Leave the old "Nesty is coming" post up.** It has 10 reactions and 4 reposts —
your best-performing content so far — and deleting it erases the only proof the
page has a history. Post 01 will sit above it and re-frame it as a "before".
