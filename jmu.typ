// ============================================================
// JMU Brand – Quarto Typst Template  (jmu.typ)
// Based on JMU Identity Guidelines https://www.jmu.edu/identity
//
// How pandoc template syntax works here:
//   $variable$          → replaced with its value before Typst sees the file
//   $if(variable)$ … $endif$   → conditional block
//   $for(list)$ … $endfor$     → loop
//   These tokens must appear as raw Typst content, NOT inside
//   Typst string literals ("…") or #let assignments.
// ============================================================

// ────────────────────────────────────────────────────────────
// 1. COLOUR PALETTE
// ────────────────────────────────────────────────────────────
#let c-purple       = rgb("#450084")
#let c-purple-med   = rgb("#B599CE")
#let c-purple-light = rgb("#DACCE6")
#let c-gold         = rgb("#CBB677")
#let c-gold-dark    = rgb("#AD9C65")
#let c-gold-light   = rgb("#F4EFE1")
#let c-gray         = rgb("#333333")
#let c-gray-dark    = rgb("#595959")
#let c-gray-medium  = rgb("#B2B2B2")
#let c-gray-light   = rgb("#D6D6D6")
#let c-green-dark   = rgb("#5F791C")
#let c-blue-dark    = rgb("#3C738B")
#let c-blue-medium  = rgb("#5498B6")
#let c-red          = rgb("#A4232B")

// ────────────────────────────────────────────────────────────
// 2. PAGE LAYOUT
// ────────────────────────────────────────────────────────────
#set page(
  paper: "us-letter",
  margin: (top: 1in, bottom: 1in, left: 1.25in, right: 1in),
  numbering: "1",
  number-align: right,
  // Running header — hidden on page 1
  header: context {
    let pg = counter(page).get().first()
    if pg > 1 {
      stack(
        dir: ttb,
        spacing: 4pt,
        grid(
          columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          // $title$ is replaced by pandoc — safe as Typst content
          text(font: "Helvetica", size: 8.5pt, weight: 500,
               fill: c-purple)[$title$],
          text(font: "Helvetica", size: 8.5pt,
               fill: c-gray-medium)[#counter(page).display("1")]
        ),
        line(length: 100%, stroke: 0.4pt + c-gray-light)
      )
    }
  },
  footer: context {
    let pg = counter(page).get().first()
    if pg > 1 {
      stack(
        dir: ttb,
        spacing: 4pt,
        line(length: 100%, stroke: 0.4pt + c-gray-light),
        align(center,
          text(font: "Helvetica", size: 7.5pt,
               fill: c-gray-medium)[Office of Research Development • James Madison University • researchdevelopment\@jmu.edu]
        )
      )
    }
  }
)

// ────────────────────────────────────────────────────────────
// 3. BASE TYPOGRAPHY
// ────────────────────────────────────────────────────────────
#set text(
  font: "Helvetica",
  size: 11pt,
  fill: c-gray-dark,
  hyphenate: false,
  lang: "en"
)

#set par(
  justify: false,
  leading: 0.75em,
  spacing: 1.25em
)

// ────────────────────────────────────────────────────────────
// 4. HEADING STYLES  (mirrors jmu.scss h1-h4 rules)
// ────────────────────────────────────────────────────────────
#show heading: set text(font: "Helvetica", fill: c-purple)
#set heading(numbering: "1.1.1.1.")

// H1 – bold, ~100%
#show heading.where(level: 1): it => {
  v(1.3em, weak: true)
  text(size: 1em, weight: 700)[#it]
  v(1.0em, weak: true)
}
// H2 – bold, 100%
#show heading.where(level: 2): it => {
  v(1.3em, weak: true)
  text(size: 1em, weight: 700)[#it]
  v(1.0em, weak: true)
}
// H3 – italic, normal weight, 100%
#show heading.where(level: 3): it => {
  v(1.3em, weak: true)
  text(size: 1.0em, weight: 500, style: "italic")[#it]
  v(1.0em, weak: true)
}
// H4 – normal weight and style, 100%
#show heading.where(level: 4): it => {
  v(1.3em, weak: true)
  text(size: 1.0em, weight: 400)[#it]
  v(1.0em, weak: true)
}

// ────────────────────────────────────────────────────────────
// 5. LINKS  (link-color: red)
// ────────────────────────────────────────────────────────────
#show link: it => text(fill: c-red)[#it]

// ────────────────────────────────────────────────────────────
// 6. CODE  (code-bg: gray-light, code-color: gray-dark)
// ────────────────────────────────────────────────────────────
// Monospace fallback chain — Typst uses the first available family.
// Install JetBrains Mono from https://www.jetbrains.com/lp/mono/ for best
// results; otherwise falls back to common system monospace fonts.
#let mono-font = ("JetBrains Mono", "Menlo", "Consolas", "Courier New")

// Inline code
#show raw.where(block: false): it => box(
  fill: c-gray-light,
  inset: (x: 3pt, y: 1pt),
  outset: (y: 3pt),
  radius: 2pt,
  text(font: mono-font, fill: c-gray-dark, size: 0.82em)[#it]
)

// Block code (font-size: 0.775em from jmu.scss)
#show raw.where(block: true): it => block(
  fill: c-gray-light,
  inset: (x: 12pt, y: 10pt),
  radius: 4pt,
  width: 100%,
  text(font: mono-font, fill: c-gray-dark, size: 0.775em)[#it]
)

// ────────────────────────────────────────────────────────────
// 7. HORIZONTAL RULE
//    Quarto emits #horizontalrule for markdown --- dividers.
// ────────────────────────────────────────────────────────────
#let horizontalrule = {
  v(1.0em, weak: true)
  line(length: 100%, stroke: 0.5pt + c-gray-medium)
  v(1.0em, weak: true)
}

// ────────────────────────────────────────────────────────────
// 8. BLOCK QUOTES  (purple-med left rule)
// ────────────────────────────────────────────────────────────
#show quote: it => pad(
  left: 1.2em,
  block(
    width: 100%,
    stroke: (left: 3pt + c-purple-med),
    inset: (left: 10pt, top: 4pt, bottom: 4pt),
    text(fill: c-gray, style: "italic")[#it.body]
  )
)

// ────────────────────────────────────────────────────────────
// 8. TITLE PAGE
//    Pandoc conditionals used directly as Typst content — no
//    string-literal wrapping so the dollar signs never reach
//    the Typst compiler unexpanded.
// ────────────────────────────────────────────────────────────

// Full-width purple accent bar
#rect(fill: c-purple, width: 100%, height: 6pt)
#v(1.8em)

$if(title)$
#text(font: "Helvetica", size: 2.4em, weight: 700, fill: c-purple)[
  $title$
]
#v(0.35em)
#line(length: 38%, stroke: 2.5pt + c-gold)
#v(0.5em)
$endif$

$if(subtitle)$
#text(font: "Helvetica", size: 1.3em, weight: 400, fill: c-gold-dark)[
  $subtitle$
]
#v(0.5em)
$endif$

$if(by-author)$
#text(font: "Helvetica", size: 1.05em, weight: 500, fill: c-gray-dark)[
  $for(by-author)$$it.name.literal$$sep$, $endfor$
]
#v(0.25em)
$endif$

$if(date)$
#text(font: "Helvetica", size: 0.9em, fill: c-gray-medium)[
  $date$
]
#v(0.25em)
$endif$

$if(abstract)$
#v(1em)
#block(
  fill: c-purple-light,
  inset: (x: 14pt, y: 12pt),
  radius: 4pt,
  width: 100%,
  stroke: 0.5pt + c-purple-med,
)[
  #text(font: "Helvetica", size: 0.88em, weight: 600, fill: c-purple)[Abstract]
  #v(0.35em)
  #text(size: 0.9em, fill: c-gray)[
    $abstract$
  ]
]
$endif$

#v(1.5em)

// ────────────────────────────────────────────────────────────
// 9. TABLE OF CONTENTS (optional)
// ────────────────────────────────────────────────────────────
$if(toc)$
#outline(
  title: text(font: "Helvetica", weight: 600, fill: c-purple)[Contents],
  indent: 1.5em,
  depth: $toc-depth$,
)
#pagebreak()
$endif$

// ────────────────────────────────────────────────────────────
// 10. DOCUMENT BODY
// ────────────────────────────────────────────────────────────
$body$
