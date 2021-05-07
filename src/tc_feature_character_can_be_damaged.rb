require_relative "character"
require "test/unit"
 
class TestCharacter < Test::Unit::TestCase

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
    testAttacker = Character.new("Bob", "Good")
    testCharacter = Character.new("Dead Man", "Good", 1)

    testAttacker.attack(testCharacter, 20)

    assert_equal(0, testCharacter.hitpoints)
    assert_equal(true, testCharacter.isDead)
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