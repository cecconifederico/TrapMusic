extensions [CSV rnd]
turtles-own [l-opinion i-gender i-age i-performance i-competence i-play i-preferences i-tips i-time i-share i-interview i-live i-quotes i-dress i-mom i-dad i-class i-mu i-theta]
;; l vuol dire lista
;; i-mu e i-theta diventano attive solo se diventano eterogenee

patches-own [influence]

globals [
    populations
    gender
    age
    school-performance
    music-competence
    band-play
    music-tips
    music-time
    music-preferences
    social-share
    music-interview
    music-live
    music-quotes
    music-dress
    mom-study
    dad-study
    class

  ]




to load-populations
  set populations but-first csv:from-file "surveynew.csv"
end

to setup
  clear-all

  load-populations
  setup-turtles
  if modality = "mix" [
   setup-network-mix
  ]
  if modality = "random" [
    setup-network-random
  ]
  reset-ticks
end

to setup-network-random
  let NumberArcs0 round (K0 * (N - 1))
  repeat NumberArcs0
  [
    let x one-of turtles
    let y nobody
    ask x [
      set y one-of other turtles with [not link-neighbor? myself]
      create-link-with y
    ]
  ]
end

to setup-network-mix
  ask patches
  [
    let distances abs(pxcor) + abs(pycor)
    let maxdistances max-pxcor + max-pycor
    set distances distances / maxdistances
    set influence (1 - distances)
  ]
  let NumberArcs0 round (K0 * (N - 1))
  let NumberArcs round (K * N * (N - 1))

  repeat NumberArcs0
  [
    let x one-of turtles
    let y nobody
    ask x [
      set y one-of other turtles with [not link-neighbor? myself]
      create-link-with y
    ]
  ]
  repeat NumberArcs
  [
    let x one-of turtles
    let y find_node x
    if y != nobody
    [
      ask x [create-link-with y]
    ]
  ]
  ask turtles [
    if not any? link-neighbors [
      create-link-with one-of other turtles
    ]
  ]
end

to setup-turtles

  let list-gender map [[x] -> (item 28 x)] populations ;; 27th column, school-performance
  set list-gender filter [[y] -> y > -1 ] list-gender
  set gender []
  (foreach [1 2][[z] ->
    let list-one-gender filter [[y] -> y = z] list-gender
    let one-probability (length list-one-gender) / (length list-gender)
    set gender lput (list z one-probability) gender
    ])
show gender

  let list-performance map [[x] -> (item 27 x)] populations ;; 27th column, school-performance
  set list-performance filter [[y] -> y > -1 ] list-performance
  set school-performance []
  (foreach [1 2 3 4 5][[z] ->
    let list-one-performance filter [[y] -> y = z] list-performance
    let one-probability (length list-one-performance) / (length list-performance)
    set school-performance lput (list z one-probability) school-performance
    ])
show school-performance

  let list-competence map [[x] -> (item 2 x)] populations
  set list-competence filter [[y] -> y > -1 ] list-competence
  set music-competence []
  (foreach [1 2][[z] ->
    let list-one-competence filter [[y] -> y = z] list-competence
    let one-probability (length list-one-competence) / (length list-competence)
    set music-competence lput (list z one-probability) music-competence
    ])
  show music-competence

  let list-play map [[x] -> (item 3 x)] populations
  set list-play filter [[y] -> y > -1 ] list-play
  set band-play []
  (foreach [1 2][[z] ->
    let list-one-play filter [[y] -> y = z] list-play
    let one-probability (length list-one-play) / (length list-play)
    set band-play lput (list z one-probability) band-play
    ])
  show band-play

  let list-tips map [[x] -> (item 1 x)] populations
  set list-tips filter [[y] -> y > -1 ] list-tips
  set music-tips []
  (foreach [1 2 3][[z] ->
    let list-one-tips filter [[y] -> y = z] list-tips
    let one-probability (length list-one-tips) / (length list-tips)
    set music-tips lput (list z one-probability) music-tips
    ])
  show music-tips

   let list-time map [[x] -> (item 14 x)] populations
  set list-time filter [[y] -> y > -1 ] list-time
  set music-time []
  (foreach [1 2 3 4][[z] ->
    let list-one-time filter [[y] -> y = z] list-time
    let one-probability (length list-one-time) / (length list-time)
    set music-time lput (list z one-probability) music-time
    ])
  show music-time


  let list-preferences map [[x] -> (item 13 x)] populations
  set list-preferences filter [[y] -> y > -1 ] list-preferences
  set music-preferences []
  (foreach [1 2 3 4 5 6 7 8 9][[z] ->
    let list-one-preferences filter [[y] -> y = z] list-preferences
    let one-probability (length list-one-preferences) / (length list-preferences)
    set music-preferences lput (list z one-probability) music-preferences
    ])
  show music-preferences


  let list-share map [[x] -> (item 15 x)] populations
  set list-share filter [[y] -> y > -1 ] list-share
  set social-share []
  (foreach [1 2 3 4 5][[z] ->
    let list-one-share filter [[y] -> y = z] list-share
    let one-probability (length list-one-share) / (length list-share)
    set social-share lput (list z one-probability) social-share
    ])
  show social-share


  let list-interview map [[x] -> (item 16 x)] populations
  set music-interview []
  (foreach [1 2][[z] ->
    let list-one-interview filter [[y] -> y = z] list-interview
    let one-probability (length list-one-interview) / (length list-interview)
    set music-interview lput (list z one-probability) music-interview
    ])
  show music-interview

    let list-live map [[x] -> (item 17 x)] populations
  set music-live []
  (foreach [1 2][[z] ->
    let list-one-live filter [[y] -> y = z] list-live
    let one-probability (length list-one-live) / (length list-live)
    set music-live lput (list z one-probability) music-live
    ])
  show music-live

    let list-quotes map [[x] -> (item 18 x)] populations
  set list-quotes filter [[y] -> y > -1 ] list-quotes
  set music-quotes []
  (foreach [1 2 3 4][[z] ->
    let list-one-quotes filter [[y] -> y = z] list-quotes
    let one-probability (length list-one-quotes) / (length list-quotes)
    set music-quotes lput (list z one-probability) music-quotes
    ])
  show music-quotes

    let list-dress map [[x] -> (item 19 x)] populations
  set music-dress []
  (foreach [1 2 3 4][[z] ->
    let list-one-dress filter [[y] -> y = z] list-dress
    let one-probability (length list-one-dress) / (length list-dress)
    set music-dress lput (list z one-probability) music-dress
    ])
  show music-dress

  let list-age map [[x] -> (item 29 x)] populations
  set list-age filter [[y] -> y > -1 ] list-age
  set age []
  (foreach [1 2 3 4 5 6 7][[z] ->
    let list-one-age filter [[y] -> y = z] list-age
    let one-probability (length list-one-age) / (length list-age)
    set age lput (list z one-probability) age
    ])
  show age

let list-mom map [[x] -> (item 31 x)] populations
  set mom-study []
  (foreach [1 2 3 4 5][[z] ->
    let list-one-mom filter [[y] -> y = z] list-mom
    let one-probability (length list-one-mom) / (length list-mom)
    set mom-study lput (list z one-probability) mom-study
    ])
  show mom-study

  let list-dad map [[x] -> (item 32 x)] populations
  set dad-study []
  (foreach [1 2 3 4 5][[z] ->
    let list-one-dad filter [[y] -> y = z] list-dad
    let one-probability (length list-one-dad) / (length list-dad)
    set dad-study lput (list z one-probability) dad-study
    ])
  show dad-study

  let list-class map [[x] -> (item 33 x)] populations
  set list-class filter [[y] -> y > -1 ] list-class
  set class []
  (foreach [1 2 3 4 5][[z] ->
    let list-one-class filter [[y] -> y = z] list-class
    let one-probability (length list-one-class) / (length list-class)
    set class lput (list z one-probability) class
    ])
  show class

  create-turtles N
  [
    set shape "circle"
    set size 0.5
    set l-opinion []
    set i-mu "null"
    set i-theta "null"
  ]


  ask turtles
  [
    set xcor random-xcor
    set ycor random-ycor
    let opinion-distribution [[0 0.25] [0.25 0.25] [0.5 0.25] [1 0.25]]
    (foreach ["rock" "classic" "jazz" "dance" "pop" "rap" "trap" "reggae" "indie"][[x] ->
      set l-opinion lput (list x first rnd:weighted-one-of-list opinion-distribution [ [p] -> last p ]) l-opinion
      ])
    set i-gender first rnd:weighted-one-of-list gender [ [p] -> last p ]
    set i-performance first rnd:weighted-one-of-list school-performance [ [p] -> last p ]
    set i-competence first rnd:weighted-one-of-list music-competence [ [p] -> last p ]
    set i-play first rnd:weighted-one-of-list band-play [[p] -> last p]
    set i-preferences first rnd:weighted-one-of-list music-preferences [[p] -> last p]
    set i-tips first rnd:weighted-one-of-list music-tips [[p] -> last p]
    set i-time first rnd:weighted-one-of-list music-time [[p] -> last p]
    set i-interview first rnd:weighted-one-of-list music-interview [[p] -> last p]
    set i-share first rnd:weighted-one-of-list social-share [[p] -> last p]
    set i-live first rnd:weighted-one-of-list music-live [[p] -> last p]
    set i-quotes first rnd:weighted-one-of-list music-quotes [[p] -> last p]
    set i-dress first rnd:weighted-one-of-list music-dress [[p] -> last p]
  ]
  colour
  reset-ticks
end



to go
  if  (ticks > 5000)
[
  stop
]

  diffusion
  colour
  tick
end

to diffusion
  ask turtles
  [
   let talker self
   let receiver nobody
    if modality = "without network"[
    set receiver one-of other turtles
    ]
    if modality = "mix" or modality = "random"
    [
      set receiver one-of other turtles with [link-neighbor? myself]
    ]
    ask talker
    [
      set i-mu mu
      if leadership_opinion? talker [set i-mu i-mu + (1 - i-mu) * 0.15]
    ]
    ask receiver [set i-mu mu ]
    (foreach (list 0 1 2 3 4 5 6 7 8)  [[x] ->
      let argument first (item x [l-opinion] of talker)
      let talker-opinion last (item x [l-opinion] of talker)
      let receiver-opinion last (item x [l-opinion] of receiver)
      if ((distance_between talker receiver) < theta) [
          ask talker [
          let new-opinion talker-opinion + [i-mu] of receiver * (receiver-opinion - talker-opinion)
           set l-opinion replace-item x l-opinion (list argument new-opinion)
          ]
          ask receiver [
          let new-opinion receiver-opinion + [i-mu] of talker * (talker-opinion - receiver-opinion)
           set l-opinion replace-item x l-opinion (list argument new-opinion)
          ]
        ]
      ])
  ]
end

  to colour

end

to-report calculate_grade
   let grade_tot 0
  ask turtles
  [
    set grade_tot grade_tot + count my-links
  ]
report grade_tot
end


to-report find_node [start]
  let pick random-float calculate_grade
  let winner nobody
  let arrivi nobody
  ask start
  [
    set arrivi other turtles with [not (link-neighbor? myself)]
  ]
    if any? arrivi
    [
      if winner = nobody
    [
      ask arrivi
      [
        ifelse ((count my-links) > pick) or vantaggio_geo?
        [
          set winner self
        ]
        [
          set pick pick - (count my-links)
        ]
      ]
    ]
  ]
  report winner
end

to-report vantaggio_geo?
  let distances abs(xcor) + abs(ycor)
    let maxdistances max-pxcor + max-pycor
    set distances distances / maxdistances
  ifelse (random-float 1) < (distances / 2)
  [report true]
  [report false]
end

to-report distance_between [T R]
  let tot 0
  let x 0
  let y 0
  ifelse ([i-gender] of T = "male") [set x 0][set x 1]
  ifelse ([i-gender] of R = "male") [set y 0][set y 1]
  set tot tot + (abs x - y)
  set x [i-competence] of T - 1
  set y [i-competence] of R - 1
  set tot tot + (abs x - y)
  set x [i-play] of T - 1
  set y [i-play] of R - 1
  set tot tot + (abs x - y)
  set x [i-preferences] of T - 7
  set y [i-preferences] of R - 7
  set tot tot + (abs x - y)
  set x [i-live] of T - 1
  set y [i-live] of R - 1
  set tot tot + (abs x - y)
  set x [i-dress] of T - 3
  set y [i-dress] of R - 3
  set tot tot + (abs x - y)
  set x [i-quotes] of T - 3
  set y [i-quotes] of R - 3
  set tot tot + (abs x - y)
  set x [i-performance] of T - 4
  set y [i-performance] of R - 4
  set tot tot + (abs x - y)
  report tot / 8
end

to-report leadership_opinion? [agent]
  let tot 0
  set tot tot + [i-competence] of agent
  set tot tot + [i-play] of agent
  set tot tot + [i-live] of agent
  set tot tot + [i-dress] of agent
  set tot tot + [i-quotes] of agent
  set tot tot + [i-time] of agent
  let P tot / 18
  ifelse P > (random-float 1)
  [report true]
  [report false]
end



;to-report free-time-activity-definition-list
;  report (list
;    ;     location-type      task
;    (list "music"           [ -> socialize no ]        )
;    (list "shopping"        [ -> socialize no ]        )
;    (list "videogames"      [ -> socialize no ]        )
;    (list "movies"          [ -> socialize no ]        )
;    (list "books"           [ -> socialize no ]        )
;    (list "sport"           [ -> socialize ]        )
;    (list "hangout"         [ -> socialize ]        )
;  )
;end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
647
448
-1
-1
13.0
1
10
1
1
1
0
0
0
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
114
96
177
129
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
17
150
189
183
N
N
1
500
150.0
1
1
NIL
HORIZONTAL

SLIDER
24
249
196
282
K
K
0.01
0.2
0.1
0.001
1
NIL
HORIZONTAL

SLIDER
23
285
195
318
K0
K0
0.01
0.2
0.1
0.001
1
NIL
HORIZONTAL

SLIDER
23
324
195
357
speed
speed
0
3
0.5
0.1
1
NIL
HORIZONTAL

BUTTON
33
97
96
130
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
651
11
1404
448
plot 1
NIL
NIL
0.0
10.0
0.0
1.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot standard-deviation [last item 0 l-opinion] of turtles"
"pen-1" 1.0 0 -7500403 true "" "plot standard-deviation [last item 1 l-opinion] of turtles"
"pen-2" 1.0 0 -2674135 true "" "plot standard-deviation [last item 2 l-opinion] of turtles"
"pen-3" 1.0 0 -955883 true "" "plot standard-deviation [last item 3 l-opinion] of turtles"
"pen-4" 1.0 0 -6459832 true "" "plot standard-deviation [last item 4 l-opinion] of turtles"
"pen-5" 1.0 0 -1184463 true "" "plot standard-deviation [last item 5 l-opinion] of turtles"
"pen-6" 1.0 0 -10899396 true "" "plot standard-deviation [last item 6 l-opinion] of turtles"
"pen-7" 1.0 0 -13840069 true "" "plot standard-deviation [last item 7 l-opinion] of turtles"
"pen-8" 1.0 0 -14835848 true "" "plot standard-deviation [last item 8 l-opinion] of turtles"

SLIDER
31
411
203
444
mu
mu
0
1
1.0
0.05
1
NIL
HORIZONTAL

SLIDER
31
451
203
484
theta
theta
0
1
0.1
0.05
1
NIL
HORIZONTAL

CHOOSER
19
192
158
237
modality
modality
"without network" "random" "mix"
0

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment_media_dev_stan_opinioni_9_9_new" repetitions="15" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="500"/>
    <metric>standard-deviation [last item 0 l-opinion] of turtles</metric>
    <metric>standard-deviation [last item 1 l-opinion] of turtles</metric>
    <metric>standard-deviation [last item 2 l-opinion] of turtles</metric>
    <metric>standard-deviation [last item 3 l-opinion] of turtles</metric>
    <metric>standard-deviation [last item 4 l-opinion] of turtles</metric>
    <metric>standard-deviation [last item 5 l-opinion] of turtles</metric>
    <metric>standard-deviation [last item 6 l-opinion] of turtles</metric>
    <metric>standard-deviation [last item 7 l-opinion] of turtles</metric>
    <metric>standard-deviation [last item 8 l-opinion] of turtles</metric>
    <metric>mean [last item 0 l-opinion] of turtles</metric>
    <metric>mean [last item 1 l-opinion] of turtles</metric>
    <metric>mean [last item 2 l-opinion] of turtles</metric>
    <metric>mean [last item 3 l-opinion] of turtles</metric>
    <metric>mean [last item 4 l-opinion] of turtles</metric>
    <metric>mean [last item 5 l-opinion] of turtles</metric>
    <metric>mean [last item 6 l-opinion] of turtles</metric>
    <metric>mean [last item 7 l-opinion] of turtles</metric>
    <metric>mean [last item 8 l-opinion] of turtles</metric>
    <enumeratedValueSet variable="mu">
      <value value="0.1"/>
      <value value="0.25"/>
      <value value="0.5"/>
      <value value="0.75"/>
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="N">
      <value value="150"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="speed">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="K">
      <value value="0.71"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="theta">
      <value value="0.1"/>
      <value value="0.25"/>
      <value value="0.5"/>
      <value value="0.75"/>
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="K0">
      <value value="0.65"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
