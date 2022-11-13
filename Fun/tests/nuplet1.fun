let x = 1 in
let t = (x + x, if true then 12 else x, let y = 12 in y + 3) in
t[0]