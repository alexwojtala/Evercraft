require 'character'

RSpec.describe "characters" do
  def character(params = {})
    defaults = {
      name: "Bob",
      alignment: "Good",
      hitpoints: 5,
      strength: 10,
      dexterity: 10,
      constitution: 10,
      wisdom: 10,
      intelligence: 10,
      charisma: 10,
      experience: 0,
    }

    Character.new(defaults.merge(params))
  end

  def test_attacker
    @test_attacker ||= character
  end

  def test_attackee
    @test_attackee ||= character(name: "Ron", alignment: "Evil")
  end

  it "start at level 1" do
    cool_joe = Character.create_character("Cool Joe", " Good")
    expect(cool_joe.level).to eq 1
  end

  it "are dead if zero hitpoints remain" do
    test_character = character(hitpoints: 0)
    expect(test_character.hitpoints_remaining).to eq 0
    expect(test_character.isDead).to eq true
  end

  it "do not take damage if dead" do
    test_character = character(hitpoints: 0)
    expect(test_character.hitpoints_remaining).to eq 0
    expect(test_character.isDead).to eq true

    test_attacker.attack(test_character, 20)
    expect(test_character.hitpoints_remaining).to eq 0
  end

  it "gain 10 experience for each hit" do
    expect(test_attacker.experience).to eq 0
    expect(test_attacker.attack(test_attackee, 10)).to eq "Hit"
    expect(test_attacker.experience).to eq 10
  end

  it "gain 10 experience for each critical hit" do
    expect(test_attacker.experience).to eq 0
    expect(test_attacker.attack(test_attackee, 20)).to eq "Critical Hit"
    expect(test_attacker.experience).to eq 10
  end

  it "gain 0 experience for each miss" do
    expect(test_attacker.experience).to eq 0
    expect(test_attacker.attack(test_attackee, 5)).to eq "Miss"
    expect(test_attacker.experience).to eq 0
  end

  it "attack roll is increased by 1 for every even numbered level achieved" do
    level_2_character = character(experience: 1000)
    level_4_character = character(experience: 3031)
    level_10_character = character(experience: 9817)


    expect(level_2_character.attack(test_attackee, 8)).to eq "Miss"
    expect(level_2_character.attack(test_attackee, 9)).to eq "Hit"
    expect(level_4_character.attack(test_attackee, 7)).to eq "Miss"
    expect(level_4_character.attack(test_attackee, 8)).to eq "Hit"
    expect(level_10_character.attack(test_attackee, 4)).to eq "Miss"
    expect(level_10_character.attack(test_attackee, 5)).to eq "Hit"
  end

  it "gain a level for each 1000 experience gained" do
    level_2_character = character(experience: 1000)
    level_3_character = character(experience: 2031)
    level_10_character = character(experience: 9817)
    level_11_character = character(experience: 10000)
    expect(level_2_character.level).to eq 2
    expect(level_3_character.level).to eq 3
    expect(level_10_character.level).to eq 10
    expect(level_11_character.level).to eq 11
  end

  context "when passing experience threshold after an attack" do
    it "level will increase by 1" do
      level_1_character = character(experience: 990)

      expect(level_1_character.level).to eq 1
      level_1_character.attack(test_attackee, 10)
      expect(level_1_character.level).to eq 2
    end
    it "hitpoints will increase by 5" do
      level_1_character = character(experience: 990)

      expect(level_1_character.hitpoints).to eq 5
      level_1_character.attack(test_attackee, 10)
      expect(level_1_character.hitpoints).to eq 10
    end
    it "hitpoints_remaining will increase by 5" do
      level_1_character = character(experience: 990)

      expect(level_1_character.hitpoints_remaining).to eq 5
      level_1_character.attack(test_attackee, 10)
      expect(level_1_character.hitpoints_remaining).to eq 10
    end
  end

  context "with base levels" do
    it "hit with a roll of 10 or above" do
      expect(test_attacker.attack(test_attackee, 10)).to eq "Hit"
    end

    it "miss with a roll of 9 or less" do
      expect(test_attacker.attack(test_attackee, 9)).to eq "Miss"
    end

    it "critical hit with a roll of 20" do
      expect(test_attacker.attack(test_attackee, 20)).to eq "Critical Hit"
    end

    it "take 1 damage when hit" do
      expect(test_attackee.hitpoints_remaining).to eq 5
      test_attacker.attack(test_attackee, 10)
      expect(test_attackee.hitpoints_remaining).to eq 4
    end

    it "take 2 damage for a critical hit" do
      expect(test_attackee.hitpoints_remaining).to eq 5
      test_attacker.attack(test_attackee, 20)
      expect(test_attackee.hitpoints_remaining).to eq 3
    end
  end
  context "with constitution modifier" do
    it "will increase hitpoints by 5 plus constitution modifier when leveling up" do
      level_1_character_with_max_constitution = character(experience: 990, constitution: 20)

      expect(level_1_character_with_max_constitution.level).to eq 1
      expect(level_1_character_with_max_constitution.hitpoints).to eq 10
      expect(level_1_character_with_max_constitution.hitpoints_remaining).to eq 10
      level_1_character_with_max_constitution.attack(test_attackee, 10)
      expect(level_1_character_with_max_constitution.level).to eq 2
      expect(level_1_character_with_max_constitution.hitpoints).to eq 20
      expect(level_1_character_with_max_constitution.hitpoints_remaining).to eq 20
    end
  end
end