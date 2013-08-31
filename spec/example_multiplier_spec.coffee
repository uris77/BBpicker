describe "any number multiplied by 0 is 0", ->
  When -> @product = calculator.multiply(98, 0)
  Then -> expect(@product).toBe(0)