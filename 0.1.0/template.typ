// breezy-stripped: Stripped version of the Breezy template to remove all excess pages and add new functions
// Author: Breanna Barraclough
// License: MIT-0
 
#let accent-colour = state("accent",rgb("#300649"))

#let headingFont = ("Montserrat","Arial")

//Alternate bold
#let bb(body) = text(
  fill: accent-colour.get(),
  font: headingFont,
  weight: "bold",
  body,
)

//Alternate italics
#let bi(body) = text(
  fill: accent-colour.get(),
  weight: "regular",
  body,
  style: "italic"
)

#let info-grid(info, cols: 3) = context grid(
  columns: (1fr,) * cols,
  gutter: 0.5em,
  align: horizon,
  ..info.map(i => grid.cell(
    colspan: if "span" in i { i.span } else { 1 },
    box(
      width: 100%,
      fill: accent-colour.get().lighten(94%),
      stroke: accent-colour.get().lighten(60%),
      radius: 4pt,
      inset: (x: 8pt, y: 10pt),
      if "formula" in i [
        #align(center)[#text(size: 1.4em)[#i.formula]]
      ] else [
        #bb[#i.sym] — #i.desc
      ]
    )
  ))
)

//Main template formatting
#let breezy(
  accent:rgb("#300649"),
  table-header-text-colour:white,
  report
) = [

  #accent-colour.update(accent)

  #let secondaryColour = accent.lighten(20%)

  #set par(leading: 0.75em, spacing: 1.2em)

  #show heading: it => block(
    above:1.5em,
    below:1em,
    text(font: headingFont,fill:accent,it) 
  )

  #set heading(
    numbering: "1.",
  )

//Code block formatting

#show raw.where(block:false): it => box(
    fill: accent.lighten(90%),
    inset:(x:2.5pt,y:2pt),
    radius:3pt,
    width:auto,
    baseline:-0.5pt,
    text(fill:accent,size:9pt,it)
)
  #show raw.where(block:true): it => block(
    fill: accent.lighten(90%),
    inset:12pt,
    radius:3pt,
    width:100%,
    text(fill:luma(15%),it)
  )

  #show figure.where(kind: raw): it => [
    #align(left)[#it.body]
    #align(center)[#it.caption]
  ]

// Defaults
  #set text(font:"Georgia")
  #set line(length:100%)
  #set list(
    marker: (
      [#text(fill: accent)[•]], 
      [#text(fill: accent)[‣]], 
      [#text(fill: accent)[–]]
    )
  )

  #show ref: it => text(fill: accent, it)
  #show cite: it => text(fill: accent, it)
  #show link: it => text(fill:accent,it)

  #show ref.where(): set text(font:headingFont,size:10pt)

  // Provide custom supplements for each figure type
  #show figure.where(kind: image): set figure(supplement: [Fig.])
  #show figure.where(kind: table): set figure(supplement: [Tab.])
  #show figure.where(kind: raw): set figure(supplement: [Snip.])

  //Colours all supplements to the accent colour
  #show figure.caption: it => [
    #text(font:headingFont, size:10pt,fill: accent,weight:"bold")[
      #it.supplement #it.counter.display(it.numbering)#it.separator]
    #text(font:headingFont,size:10pt)[#it.body]
  ]
  // Custom table settings where the heading is bold, white, serif font. Table has light accent borders and left-aligned text. Caption is above table.

  #show figure.where(kind: table): set figure.caption(position:top) 

  #show table.cell.where(y: 0): set text(
    weight: "bold",
    font:headingFont,
    fill: table-header-text-colour
  )
  #set table(
    stroke:0.5pt + accent.lighten(50%),
    fill: (x,y) => {
      if y == 0 {accent}
    },
    inset:5pt,
    align:left
  )

  // Page settings

  #set page(
    paper: "a4",
    margin: (top: 1.5cm, bottom: 1.5cm, left: 1.5cm, right: 1.5cm),
  )

  // Create page number in footer, removing title page from the count
  #counter(page).update(1)
  #set page(
    footer: context{
      align(center,
        text(fill:accent)[-- #counter(page).get().first() --]
      )
    },
  )

  #outline()
  #pagebreak()
  #report
]