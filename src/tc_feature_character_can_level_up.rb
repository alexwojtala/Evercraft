require_relative "character"
require "test/unit"
 
class TestCharacter < Test::Unit::TestCase
 
  def test_character_will_start_at_level_1
    testCharacter = Character.new("Bob", "Good")
    assert_equal(1, testCharacter.level)
  end

  def test_character_will_level_up_every_1000_experience
    level_2_character = Character.with_experience("Bob", "Good", 1000)
    level_3_character = Character.with_experience("Bob", "Good", 2031)
    level_10_character = Character.with_experience("Bob", "Good", 9817)
    level_11_character = Character.with_experience("Bob", "Good", 10000)
    assert_equal(2, level_2_character.level)
    assert_equal(3, level_3_character.level)
    assert_equal(10, level_10_character.level)
    assert_equal(11, level_11_character.level)
  end

  def test_character_will_increase_hitpoints_by_5_with_each_level
    level_2_character = Character.with_experience("Bob", "Good", 1000)
    level_3_character = Character.with_experience("Bob", "Good", 2031)
    level_10_character = Character.with_experience("Bob", "Good", 9817)
    level_11_character = Character.with_experience("Bob", "Good", 10000)
    assert_equal(10, level_2_character.hitpoints)
    assert_equal(15, level_3_character.hitpoints)
    assert_equal(50, level_10_character.hitpoints)
    assert_equal(55, level_11_character.hitpoints)
  end

  def test_character_will_increase_attack_roll_by_1_for_each_even_level_achievment
    level_2_character = Character.with_experience("Bob", "Good", 1000)
    level_4_character = Character.with_experience("Bob", "Good", 3031)
    level_10_character = Character.with_experience("Bob", "Good", 9817)

    character_to_attack = Character.new("Evil Bob", "Evil")

    assert_equal("Miss", level_2_character.attack(character_to_attack, 8))
    assert_equal("Hit", level_2_character.attack(character_to_attack, 9))
    assert_equal("Miss", level_4_character.attack(character_to_attack, 7))
    assert_equal("Hit", level_4_character.attack(character_to_attack, 8))
    assert_equal("Miss", level_10_character.attack(character_to_attack, 4))
    assert_equal("Hit", level_10_character.attack(character_to_attack, 5))
  end

end