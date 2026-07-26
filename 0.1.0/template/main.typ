#import "@local/breezy-stripped:0.1.0": breezy, info-grid, bi,bb

#show: breezy.with(
  accent: rgb("#300649"),
)

= Section
#lorem(20)
- List item 1
  - List item sub 1

#lorem(20)

== Subsection
#lorem(40)
#figure(
  table(
    columns:(1fr,1fr),
    [Heading 1],[Heading 2],
    [#lorem(10)],[#lorem(5)]
),
caption:"Caption for a table."
)
= Section
#lorem(20)

```c
#int main()
{
  int count = 0;

  while (1)
  {
    for (int i = 0; i < 5; i++)
    {
      printf(count);
      count++;
    }
  }
}

```

=== Formula Example
#let formulas-1st = (
  (formula: $tau = frac(1, a)$),
  (formula: $t_r = frac(2.2, a)$),
  (formula: $t_s = frac(4,a)$)
)

#info-grid(formulas-1st)

=== Info Example
#let terms = (
  (sym: "ft", desc: "function in time domain"),
  (sym: "Fs", desc: "function in s domain"),
  (sym: "Gs", desc: "transfer function in s domain"),
)

#info-grid(terms)
