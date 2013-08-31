describe "any number plus 0 is the number", ->
  When -> @sum = org.uris77.sum(20, 0)
  Then -> expect(@sum).toBe(20)