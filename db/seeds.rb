# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Unit.create(unit: "ounces", factor: 0.028349523125, m: 0, kg: 1, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "pounds", factor: 0.45359237, m: 0, kg: 1, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "grams", factor: 0.001, m: 0, kg: 1, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "kilograms", factor: 1.0, m: 0, kg: 1, s: 0, a: 0, k: 0, cd: 0, mol: 0)


Unit.create(unit: "count", factor: 1.0, m: 0, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "dozen", factor: 12.0, m: 0, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)


Unit.create(unit: "gallons", factor: 473176473.0/125000000000.0, m: 3, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "quarts", factor: 473176473.0/31250000000.0, m: 3, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "pints", factor: 473176473.0/15625000000.0, m: 3, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "fluid ounces", factor: 473176473.0/976562500.0, m: 3, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "cubic feet", factor: 55306341.0/1953125000.0, m: 3, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "cubic yards", factor: 1493271207.0/1953125000.0, m: 3, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "cubic inches", factor: 2048383.0/125000000000.0, m: 3, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "liters", factor: 0.001, m: 3, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "milliliters", factor: 0.000001, m: 3, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)


Unit.create(unit: "square feet", factor: 145161.0/1562500.0, m: 2, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "square meters", factor: 1.0, m: 2, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)


Unit.create(unit: "linear feet", factor: 381.0/1250.0, m: 1, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)
Unit.create(unit: "meters", factor: 1.0, m: 1, kg: 0, s: 0, a: 0, k: 0, cd: 0, mol: 0)


