require_relative "../lib/character"
require "test/unit"
 
class TestCharacter < Test::Unit::TestCase
 
  def test_character_will_gain_10_experience_for_each_hit
    testAttacker = Character.new("Bob", "Good")
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal(0, testAttacker.experience)
    assert_equal("Hit", testAttacker.attack(testAttackee, 10))
    assert_equal(10, testAttacker.experience)
  end

  def test_character_will_gain_10_experience_for_each_critical_hit
    testAttacker = Character.new("Bob", "Good")
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal(0, testAttacker.experience)
    assert_equal("Critical Hit", testAttacker.attack(testAttackee, 20))
    assert_equal(10, testAttacker.experience)
  end

  def test_character_will_gain_0_experience_for_a_miss
    testAttacker = Character.new("Bob", "Good")
    testAttackee = Character.new("Ron", "Neutral")
    assert_equal(0, testAttacker.experience)
    assert_equal("Miss", testAttacker.attack(testAttackee, 9))
    assert_equal(0, testAttacker.experience)
  end

end