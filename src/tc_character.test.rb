require_relative "character"
require "test/unit"
 
class TestCharacter < Test::Unit::TestCase
 
  def test_attack_should_hit_if_roll_is_greater_than_equal_to_armor_rating
    testAttacker = Character.new("Bob", "Good")
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal("Hit", testAttacker.attack(testAttackee, 10))
  end

  def test_attack_should_critical_hit_if_roll_is_20
    testAttacker = Character.new("Bob", "Good")
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal("Critical Hit", testAttacker.attack(testAttackee, 20))
  end

  def test_attack_should_miss_if_roll_is_less_than_armor_rating
    testAttacker = Character.new("Bob", "Good")
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal("Miss", testAttacker.attack(testAttackee, 9))
  end
 
  def test_attack_should_lower_hitpoints_of_attacked_character_if_there_is_a_hit
    testAttacker = Character.new("Bob", "Good")
    testAttackee = Character.new("Ron", "Neutral")
    testAttacker.attack(testAttackee, 10)
    assert_equal(4, testAttackee.hitpoints)
  end

  def test_attack_should_lower_hitpoints_by_2_if_there_is_a_critical_hit
    testAttacker = Character.new("Bob", "Good")
    testAttackee = Character.new("Ron", "Neutral")
    testAttacker.attack(testAttackee, 20)
    assert_equal(3, testAttackee.hitpoints)
  end

  def test_character_is_dead_if_hitpoints_is_zero
    testCharacter = Character.new("Bob", "Good", 0)
    assert_equal(true, testCharacter.isDead)
  end

  def test_character_higher_strength_increases_attack_roll_and_damage
    testAttacker = Character.new("Bob", "Good", 5, 12)
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal(1, testAttacker.strength_modifier)
    assert_equal("Hit", testAttacker.attack(testAttackee, 9))
    assert_equal(3, testAttackee.hitpoints)
    assert_equal("Miss", testAttacker.attack(testAttackee, 8))
  end

  def test_character_even_higher_strength_increases_attack_roll_and_damage_even_more
    testAttacker = Character.new("Bob", "Good", 5, 15)
    testAttackee = Character.new("Ron", "Neutral", 5)
    assert_equal(2, testAttacker.strength_modifier)
    assert_equal("Hit", testAttacker.attack(testAttackee, 8))
    assert_equal(2, testAttackee.hitpoints)
    assert_equal("Miss", testAttacker.attack(testAttackee, 7))
  end

  def test_character_lower_than_base_strength_of_10_decreases_attack_roll_and_damage
    testAttacker = Character.new("Bob", "Good", 5, 8)
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal(-1, testAttacker.strength_modifier)
    assert_equal("Hit", testAttacker.attack(testAttackee, 11))
    assert_equal(4, testAttackee.hitpoints)
    assert_equal("Miss", testAttacker.attack(testAttackee, 10))
  end

  def test_character_even_lower_than_base_strength_of_10_decreases_attack_roll_and_damage_even_more
    testAttacker = Character.new("Bob", "Good", 5, 5)
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal(-3, testAttacker.strength_modifier)
    assert_equal("Hit", testAttacker.attack(testAttackee, 13))
    assert_equal(4, testAttackee.hitpoints)
    assert_equal("Miss", testAttacker.attack(testAttackee, 12))
  end

  def test_character_with_weakest_strenth_has_minus_5_attack_roll_and_damage
    testAttacker = Character.new("Bob", "Good", 5, 1)
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal(-5, testAttacker.strength_modifier)
    assert_equal("Hit", testAttacker.attack(testAttackee, 15))
    assert_equal(4, testAttackee.hitpoints)
    assert_equal("Miss", testAttacker.attack(testAttackee, 14))
  end

  def test_character_with_max_strenth_has_plus_5_attack_roll_and_damage
    testAttacker = Character.new("Bob", "Good", 5, 20)
    testAttackee = Character.new("Ron", "Neutral", 10)
    assert_equal(5, testAttacker.strength_modifier)
    assert_equal("Hit", testAttacker.attack(testAttackee, 5))
    assert_equal(4, testAttackee.hitpoints)
    assert_equal("Miss", testAttacker.attack(testAttackee, 4))
  end

  def test_character_hitpoints_cannot_go_below_zero
    testAttacker = Character.new("Bob", "Good", 5)
    testAttackee = Character.new("Ron", "Neutral", 1)
    assert_equal("Critical Hit", testAttacker.attack(testAttackee, 20))
    assert_equal(0, testAttackee.hitpoints)
  end

  def test_character_hitpoints_cannot_go_below_zero
    testAttacker = Character.new("Bob", "Good", 5, 20)
    testAttackee = Character.new("Ron", "Neutral", 1)
    assert_equal("Hit", testAttacker.attack(testAttackee, 10))
    assert_equal(0, testAttackee.hitpoints)
  end

end