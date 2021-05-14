require_relative "../lib/character"
require "test/unit"
 
class TestCharacter < Test::Unit::TestCase

  def test_character_with_12_strength_increases_attack_roll_and_damage_by_1
    testAttacker = Character.with_strength("Bob", "Good", 12)
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal(1, testAttacker.strength_modifier)
    assert_equal("Hit", testAttacker.attack(testAttackee, 9))
    assert_equal(3, testAttackee.hitpoints_remaining)
    assert_equal("Miss", testAttacker.attack(testAttackee, 8))
  end

  def test_character_with_15_strength_increases_attack_roll_and_damage_by_2
    testAttacker = Character.with_strength("Bob", "Good", 15)
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal(2, testAttacker.strength_modifier)
    assert_equal("Hit", testAttacker.attack(testAttackee, 8))
    assert_equal(2, testAttackee.hitpoints_remaining)
    assert_equal("Miss", testAttacker.attack(testAttackee, 7))
  end

  def test_character_with_8_strength_decreases_attack_roll_by_1_attack_damage_is_still_1
    testAttacker = Character.with_strength("Bob", "Good", 8)
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal(-1, testAttacker.strength_modifier)
    assert_equal("Hit", testAttacker.attack(testAttackee, 11))
    assert_equal(4, testAttackee.hitpoints_remaining)
    assert_equal("Miss", testAttacker.attack(testAttackee, 10))
  end

  def test_character__with_5_strength_decreases_attack_roll_by_3_attack_damage_is_still_1
    testAttacker = Character.with_strength("Bob", "Good", 5)
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal(-3, testAttacker.strength_modifier)
    assert_equal("Hit", testAttacker.attack(testAttackee, 13))
    assert_equal(4, testAttackee.hitpoints_remaining)
    assert_equal("Miss", testAttacker.attack(testAttackee, 12))
  end

  def test_character_with_weakest_strenth_has_minus_5_attack_roll_and_attack_damage_is_still_1
    testAttacker = Character.with_strength("Bob", "Good", 1)
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal(-5, testAttacker.strength_modifier)
    assert_equal("Hit", testAttacker.attack(testAttackee, 15))
    assert_equal(4, testAttackee.hitpoints_remaining)
    assert_equal("Miss", testAttacker.attack(testAttackee, 14))
  end

  def test_character_with_max_strenth_has_plus_5_attack_roll_and_damage
    testAttacker = Character.with_strength("Bob", "Good", 20)
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal(5, testAttacker.strength_modifier)
    assert_equal("Hit", testAttacker.attack(testAttackee, 5))
    assert_equal(0, testAttackee.hitpoints_remaining)
    assert_equal("Miss", testAttacker.attack(testAttackee, 4))
  end

  def test_character_have_default_armor_modifier_of_zero
    testCharacter = Character.new("Bob", "Good")
    assert_equal(0, testCharacter.armor_modifier)
  end

  def test_character_with_dexterity_less_than_10_has_armor_less_than_10
    testCharacter = Character.with_dexterity("Bob", "Good", 8)
    assert_equal(-1, testCharacter.armor_modifier)
    assert_equal(9, testCharacter.armor)
  end

  def test_character_with_dexterity_greater_than_11_has_armor_greater_than_10
    testCharacter = Character.with_dexterity("Bob", "Good", 14)
    assert_equal(2, testCharacter.armor_modifier)
    assert_equal(12, testCharacter.armor)
  end

  def test_character_dexterity_should_modify_armor_rating
    expectedArmorRatingModifiers = [-5, -4, -4, -3, -3, -2, -2, -1, -1, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5]
    expectedArmorRatings = [5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15]
    dexterityRatings = (1..20).to_a

    puts dexterityRatings
    dexterityRatings.each_with_index do |dexterity, index|
      testCharacter = Character.with_dexterity("Bob", "Good", dexterity)
      assert_equal(expectedArmorRatingModifiers[index], testCharacter.armor_modifier)
      assert_equal(expectedArmorRatings[index], testCharacter.armor)
    end
  end

  def test_character_have_default_hitpoints_modifier_of_zero
    testCharacter = Character.new("Bob", "Good")
    assert_equal(0, testCharacter.hitpoints_modifier)
  end

  def test_character_with_constitution_less_than_10_has_hitpoints_less_than_5
    constitution = 8
    testCharacter = Character.with_constitution("Bob", "Good", constitution)
    assert_equal(-1, testCharacter.hitpoints_modifier)
    assert_equal(4, testCharacter.hitpoints)
  end

  def test_character_with_constitution_greater_than_11_has_hitpoints_greater_than_5
    constitution = 15
    testCharacter = Character.with_constitution("Bob", "Good", constitution)
    assert_equal(2, testCharacter.hitpoints_modifier)
    assert_equal(7, testCharacter.hitpoints)
  end

  def test_character_has_minimum_hitpoints_of_one
    constitution = 1
    testCharacter = Character.with_constitution("Bob", "Good", constitution)
    assert_equal(-5, testCharacter.hitpoints_modifier)
    assert_equal(1, testCharacter.hitpoints)
  end

  def test_character_constitution_should_modify_hitpoints_rating
    expectedHitpointsRatingModifiers = [-5, -4, -4, -3, -3, -2, -2, -1, -1, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5]
    expectedHitpointsRatings = [1, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10]
    constitutionRatings = (1..20).to_a

    puts constitutionRatings
    constitutionRatings.each_with_index do |constitution, index|
      testCharacter = Character.with_constitution("Bob", "Good", constitution)
      assert_equal(expectedHitpointsRatingModifiers[index], testCharacter.hitpoints_modifier)
      assert_equal(expectedHitpointsRatings[index], testCharacter.hitpoints)
    end
  end

end