# Nesty — Launch content, Sprint 1 (9 days)

Owner: Achref (founder, on camera) · Strategy: this file · Status: ready to shoot
Window: **Day 1 → Day 9**, three posts, one every three days.

---

## The read before anything else

Nesty has been invisible. The LinkedIn page has a "coming soon" card and nothing
since, while `nesty-tn.vercel.app`, `nesty-base.vercel.app` and the mobile app all
exist and work. That gap is the whole problem: **an agency owner who checks you out
finds a company that looks abandoned.** Every day the page stays frozen, the product
looks less real than it is.

So the job of these three posts is not "go viral". It is:

1. **Prove Nesty exists** — put the product on screen, publicly, dated.
2. **Prove it is different** — one feature nobody else in the market has.
3. **Convert the attention into conversations** — DMs from agency owners.

Three posts is a **test, not a campaign.** We ship these nine days, read the numbers,
and only then decide whether to build a real content engine. That sequencing is
deliberate — do not pre-build post 4-12 before post 1-3 have data.

### One thing I will not let us do

**We are not going to say "trusted by agencies across Tunisia."** We have zero paying
customers. In a market this small, a claim like that gets checked in one phone call
and it costs the founder his reputation with the other nine agencies on the list. The
landing copy was already cleaned once for exactly this reason (see the 2026-08-01
session log — invented SLA timers and "median response 4h → 11min" were removed).

Everything below claims only what actually ships. The scarcity in post 3 is real
(10 founding seats), which is why it is allowed to feel urgent.

---

## The 9-day arc

| Day | Post | Job | Format | Primary CTA | Success = |
|---|---|---|---|---|---|
| **1** | **01 · Nesty est là** | Exist. Announce. | Carousel (5) + 35s founder reel | Visit the site | Reach + profile visits |
| **4** | **02 · La visite 3D** | Differentiate. Prove. | Carousel (5) + 28s screen-record reel | Save / share | Saves + shares + comments |
| **7** | **03 · 10 agences fondatrices** | Convert. | Carousel (5) + 40s founder reel | **DM / WhatsApp** | **Qualified DMs** |

Read the arc out loud: *we exist → here's the thing you can't get elsewhere → here's
how you get in, and there are ten seats.* Post 3 only works because 1 and 2 earned
the right to ask.

---

## Channel priority (this is not equal-weight)

Per the platform doc, this segment answers on **WhatsApp > Facebook > Instagram >
phone > email**. LinkedIn is where they *verify* you, not where they *find* you.

| Channel | Role | Effort |
|---|---|---|
| **Facebook page + local groups** | Where Tunisian agency owners actually are | **Highest** |
| **Instagram Reels** | Reach, and the seeker-side audience | High |
| **Founder's personal LinkedIn** | Real distribution — post here first, always | High |
| **Nesty LinkedIn company page** | Credibility surface for anyone who checks | Mirror the personal post |
| **TikTok** | Optional; post the reel, cost is near zero | Low |

**The single highest-leverage rule in this document:** post from **Achref's personal
profile first**, then re-share to the Nesty page. A company page with ~0 followers has
no distribution. A founder's face does. Every reel is founder-led for this reason —
and it matches the plan already in the platform doc (priority #3: founder on camera,
French + Arabic, *not* motion graphics, *not* AI avatars).

---

## Language

- **French = default** for every caption. It is the working language of Tunisian real
  estate and the language of the site.
- **Arabic (Darija, Arabic script) = second block** in the same post, not a separate
  post. Agency owners code-switch constantly; a bilingual caption reads native, two
  separate posts read like a translation exercise.
- **English** = LinkedIn only, and only because LinkedIn's audience is broader.
- Reels: **speak French.** Add Darija for the hook line and the CTA if it comes out
  naturally on camera. Do not script Darija word-for-word and read it — it sounds fake.
  Burn subtitles in FR always.

> Note: the app itself has **no Arabic UI yet** (`messages/` has `en.json` + `fr.json`
> only, AR + RTL is priority #5 and unstarted). So: Arabic in **captions**, yes.
> Do **not** show Arabic UI in any screen recording, and do not promise an Arabic app
> in these three posts.

---

## What is in this folder

```
posts/
├── README.md       this file — strategy, rules, KPIs
├── BRAND-KIT.md    colours, type, logo, voice, allowed & forbidden claims
├── CALENDAR.md     the dated production + publishing schedule
├── LINKEDIN-PAGE-FIX.md  page audit + proposed copy (awaiting approval)
├── export/         ← 15 ready-to-upload PNGs, 1080×1350
├── export.sh       regenerates export/ from the HTML
├── srv.js          local server the export script renders against
└── post-0X-name/
    ├── BRIEF.md        objective, audience, hook, CTA, KPI, pre-flight checklist
    ├── captions.md     FR + AR + EN, per platform, hashtags, first comment
    ├── reel-script.md  shot-by-shot: timecode, visual, VO, on-screen text, audio
    └── carousel.html   the source for that post's slides
```

## The exported images — already done

**`export/` contains all 15 slides as ready-to-upload PNGs**, 1080×1350 each
(Instagram / Facebook / LinkedIn 4:5 portrait — the biggest slot in the feed).

```
export/post-01-nesty-is-live_slide-01.png   … slide-05
export/post-02-visite-3d_slide-01.png       … slide-05
export/post-03-founding-partners_slide-01.png … slide-05
```

Upload them in filename order. Nothing else to do.

### Regenerating them after an edit

Edit the `carousel.html`, then:

```bash
node srv.js &        # serves this folder on :8899
./export.sh          # re-renders every slide into export/
```

`export.sh` drives headless Chrome — which is code-signed and therefore
unaffected by Smart App Control, unlike the freshly-installed native binaries
that blocked the Remotion render (see platform doc). No design tool, nothing to
install.

`carousel.html?slide=N` renders a single slide full-bleed; that is what the
script screenshots. Opening `carousel.html` with no query string shows all
slides stacked for review.

The fonts come from Google Fonts, so **be online when you render**.

---

## Posting rules (apply to all three)

1. **Post 18:00–21:00 Tunis time**, weekdays. That is when agency owners are off
   viewings and on their phones.
2. **Never put a link in the body on Facebook/Instagram.** Reach gets throttled.
   Link goes in the **first comment** and in the bio.
3. **Answer every comment within an hour** for the first three hours. Early
   engagement is what the algorithm reads. Set a timer; do not "check later".
4. **Reels: hook in the first 1.5 seconds.** No intro, no logo animation, no
   "bonjour à tous". First frame is a claim or a screen.
5. **Subtitles burned in, always.** Most of the feed is watched on mute.
6. **Vertical 1080×1920 for reels. 1080×1350 for carousels.** Never 1:1.
7. **One CTA per post.** Post 3 is the only one that asks for a DM. If every post
   asks, none of them get one.

---

## What we measure (fill this in on Day 10)

Do not measure followers. Measure intent.

| Metric | Post 01 | Post 02 | Post 03 | Target |
|---|---|---|---|---|
| Reach / views | | | | 500+ combined |
| Saves + shares | | | | 15+ on post 02 |
| Comments | | | | 10+ combined |
| Profile / page visits | | | | 60+ |
| **Site sessions (Day 1-9)** | | | | **80+** |
| **Qualified DMs from agencies** | | | | **3+** |
| **Calls booked** | | | | **1+** |

**The only number that decides whether we continue: qualified DMs.** Everything else
is a vanity proxy.

### The decision rule, written in advance

- **3+ qualified DMs** → the format works. Build sprint 2 (9 more posts), and add the
  90-second personalised demo videos to the outreach sequence.
- **1–2 DMs** → the audience is right, the ask is wrong. Keep the format, rewrite the
  CTA, go harder on Facebook groups.
- **0 DMs, decent reach** → we are talking to seekers, not agencies. Stop posting to
  the feed and put the effort into direct WhatsApp outreach to the 10 identified
  agencies instead.
- **0 DMs, no reach** → distribution problem, not content problem. The founder's
  personal network is the channel; content is not.

We are not blocked on this either way — the 10-agency outreach list runs in parallel.
Social is a warm-up surface for it, not a replacement.

---

## Two things to fix before Day 1

Small, but they are what a curious agency owner hits right after the post.

1. **LinkedIn page still says "coming soon."** Update the tagline, About, website
   link and cover image before post 01 goes out, or the post sends people to a
   contradiction. Suggested tagline:
   *"Le système d'exploitation des agences immobilières tunisiennes. Annonces,
   calendrier et visites 3D en un seul endroit."*
2. **Make sure the site link works from a phone on 4G.** Every single click from
   these posts is mobile, on an inconsistent Tunisian network. Open
   `nesty-tn.vercel.app` on a phone off wifi before posting.

---

*Prepared as the launch sprint for the Nesty brand. Copy is derived from the live
French landing copy so the posts and the site say the same things in the same voice.*
