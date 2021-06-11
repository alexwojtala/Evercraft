require_relative "../lib/character"
require "test/unit"
 
class TestCharacter < Test::Unit::TestCase



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