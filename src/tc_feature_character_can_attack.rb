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

end