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
  context "with base levels" do
    def test_attacker
      @test_attacker ||= character
    end

    def test_attackee
      @test_attackee ||= character
    end

    it "Should hit with a roll of 10 or above" do
      expect(test_attacker.attack(test_attackee, 10)).to eq "Hit"
    end

    it "Should miss with a roll of 9 or less" do
      expect(test_attacker.attack(test_attackee, 9)).to eq "Miss"
    end

    it "Should critical hit with a roll of 20" do
      expect(test_attacker.attack(test_attackee, 20)).to eq "Critical Hit"
    end
  end
end