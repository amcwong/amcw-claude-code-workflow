<!-- CURRENT: Fable 5.1 | Opus 5.5 | Sonnet 5.5 | Haiku 5.5 -->

# Current Model Versions (single source of truth)

**Last verified against Anthropic docs:** 2026-10-23  
**Expires:** 2026-12-22 (60 days) — after this date the currency gate fails until re-verified.

This file is the **one place** that names current Claude model point versions. Everything else in the template should either refer to tiers abstractly ("newest Opus", "the Haiku tier") or point here. `scripts/check-model-versions.sh` flags any **superseded** version that is presented as **current** in the template's user-facing surfaces.

The machine-readable `<!-- CURRENT: ... -->` marker at the top is parsed by the checker — keep it in sync with the table.

Sources for this pass: the platform [Models overview](https://platform.claude.com/docs/en/models/overview), Claude Code [Model configuration](https://code.claude.com/docs/en/model-config), and Claude Code [Fast mode](https://code.claude.com/docs/en/fast-mode).

| Tier | Current version | Model ID | Notes |
|------|-----------------|----------|-------|
| Fable (hardest, long-horizon) | **Fable 5.1** | `claude-fable-5-1` (alias `fable`) | for demanding reasoning and long-horizon agentic work; **opt-in** (`/model fable` or the `best` alias) — not the account-type default on any plan or provider; $10/$50 per MTok; 1M context, 128K max output; default effort `high`; requires Claude Code ≥ 2.1.257; retirement not sooner than 2027-09-01 |
| Opus (high-judgment) | **Opus 5.5** | `claude-opus-5-5` (alias `opus`) | Anthropic's recommended starting point for most workloads; the Claude Code default on Pro / Max / Team / Enterprise and the Anthropic API; $4/$20 per MTok; 1M context, 128K max output; default effort `medium`; requires Claude Code ≥ 2.1.280; retirement not sooner than 2027-09-22 |
| Sonnet (workhorse) | **Sonnet 5.5** | `claude-sonnet-5-5` (alias `sonnet`) | speed/intelligence balance; $2/$10 per MTok; 1M context, 128K max output; default effort `high`; requires Claude Code ≥ 2.1.284; retirement not sooner than 2027-09-28 |
| Haiku (fast / mechanical) | **Haiku 5.5** | `claude-haiku-5-5` (alias `haiku`) | high-volume, latency-sensitive work (classification, extraction, routing); from $0.10/$0.50 per MTok; 1M context, 128K max output; default effort `medium`; requires Claude Code ≥ 2.1.293; retirement not sooner than 2027-10-07 |

From the 4.6 generation on, every model ID is a dateless pinned snapshot; the alias row on the platform docs repeats it.

**Alias resolution is provider-dependent** (verified 2026-10-23):

| Provider | `opus` | `sonnet` | `haiku` |
|---|---|---|---|
| Anthropic API | Opus 5.5 | Sonnet 5.5 | Haiku 5.5 |
| Claude Platform on AWS | Opus 5.5 | Sonnet 4.6 | Haiku 4.5 |
| Amazon Bedrock, Google Cloud's Agent Platform | Opus 5.5 | Sonnet 4.5 | Haiku 4.5 |
| Microsoft Foundry | Opus 4.6 | Sonnet 4.5 | Haiku 4.5 |

Microsoft Foundry defaults to Sonnet 4.5; every other account type defaults to Opus 5.5. Pin with a full model name or `ANTHROPIC_DEFAULT_OPUS_MODEL` / `ANTHROPIC_DEFAULT_SONNET_MODEL` / `ANTHROPIC_DEFAULT_FABLE_MODEL` where an alias resolves older. The `best` alias selects the `fable` model where Fable is available to you, otherwise the same model as `opus`. In Claude apps gateway sessions, `fable` and `best` resolve to Fable 5, not Fable 5.1.

**Fast mode** (research preview; Opus only; Anthropic API and subscription usage credits only): $8/$40 per MTok on Opus 5.5, the fast-mode default from Claude Code 2.1.280. *(Prior generation, historical: Opus 5 and Opus 4.8 fast mode are $10/$50; Opus 4.7 fast mode was removed 2026-07-24.)*

**Fable 5.1 routing caveat — needs re-measurement.** [`model-routing.md`](../rules/model-routing.md) still keeps the Fable tier off the forked-reviewer fleet on the basis of a **launch-week (2026-06) observation on Fable 5** (28/28 structured-output subagent failures vs 0 on Opus). That evidence is now ~4 months old and predates both Opus 5.5 and Fable 5.1. **Treat the routing rule as unverified until re-measured** — it is a stale recommendation of exactly the class this file exists to prevent.

**The advisor tool** (last verified 2026-08-21; **not re-checked in the 2026-10-23 pass**): experimental, Anthropic API only — set `advisorModel` or `/advisor`, and the main model consults a stronger advisor at hard decisions. Re-verify before relying on it.

## Prior generations

It is fine to mention older versions in **historical** contexts (CHANGELOG entries) or in explicit **"prior generation" / comparison** lines (e.g. "Opus 4.8's `high` does what Opus 4.7's `xhigh` did"). They must **not** be presented as the current / newest / default model.

Legacy models Anthropic lists as still available (2026-10-23):

- **Fable 5** — prior Fable generation; still what `fable` / `best` resolve to in Claude apps gateway sessions.
- **Opus 5** — prior Opus generation (was the default until Opus 5.5).
- **Opus 4.8**, **Opus 4.7**, **Opus 4.6**, **Opus 4.5** — earlier Opus generations; Opus 4.6 is still what `opus` resolves to on Microsoft Foundry.
- **Sonnet 5** — prior Sonnet generation.
- **Sonnet 4.6**, **Sonnet 4.5** — earlier Sonnet generations; still what `sonnet` resolves to on some third-party providers (see alias table above).
- **Haiku 4.5** — prior Haiku generation; still what `haiku` resolves to on every third-party provider.

The checker allows a line to mention an older version when it carries a marker such as `prior generation`, `retire`, `migrat`, `deprecat`, `or later`, `historical`, an `X.Y's` comparison, or an inline `<!-- model-allow -->` comment.

## Update protocol (when Anthropic ships a new model)

1. Update the table **and** the `<!-- CURRENT: ... -->` marker above, plus the "Last verified" date.
2. Run `./scripts/check-model-versions.sh` and fix every current-state surface it flags.
3. **Manually grep for superlatives** — `grep -rniE "newest|most capable" README.md CLAUDE.md guide/ docs/index.html .claude/rules/` — and re-verify each hit. The checker validates *version strings*; a claim like "X is the newest model" is a **semantic** assertion it can only partially catch (it flags `newest`/`most capable` lines that name a non-top tier, but tier-relative phrasings like "the newest Opus" are legitimately allowed). The 2026-06-09 Fable 5 launch made exactly this class of claim false while the gate stayed green.
4. Add a "Changed — model refresh" entry to `CHANGELOG.md`; leave historical CHANGELOG entries intact.
