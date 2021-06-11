class Character
    attr_accessor :name, :armor, :strength_modifier, :armor_modifier, :hitpoints_modifier, :experience, :hitpoints_remaining, :level

    def self.create_character(name, alignment)
        new(name: name, alignment: alignment, hitpoints: 5, strength: 10, dexterity: 10, constitution: 10, wisdom: 10, intelligence: 10, charisma: 10, experience: 0)
    end

    def initialize(name:, alignment:, hitpoints:, strength:, dexterity:, constitution:, wisdom:, intelligence:, charisma:, experience:)
        @name = name
        @alignment = alignment
        @strength = strength
        @dexterity = dexterity
        @constitution = constitution
        @wisdom = wisdom
        @intelligence = intelligence
        @charisma = charisma
        @strength_modifier = (@strength - 10)/2
        @armor_modifier = (@dexterity - 10)/2
        @armor = 10 + @armor_modifier
        @hitpoints_modifier = (@constitution - 10)/2
        @experience = experience
        @level = self.calculated_level
        @hitpoints_remaining = hitpoints + @hitpoints_modifier
    end
    def describe_character
        puts "Hi, I am #{@name}, a character with #{@alignment} alignment. I have #{@armor} armor and #{self.hitpoints} hit points."
    end
    def attack(character, natural_roll)
        roll = natural_roll + @strength_modifier + (@level / 2)
        if natural_roll == 20
            attack_damage = 2
            if attack_damage > character.hitpoints_remaining
                attack_damage = character.hitpoints_remaining
            end
            character.hitpoints_remaining = character.hitpoints_remaining - attack_damage
            @experience  = @experience + 10
            "Critical Hit"
        elsif roll >= character.armor
            attack_damage = 1 + @strength_modifier
            if attack_damage < 1
                attack_damage = 1
            end
            if attack_damage > character.hitpoints_remaining
                attack_damage = character.hitpoints_remaining
            end
            character.hitpoints_remaining = character.hitpoints_remaining - attack_damage
            @experience = @experience + 10

            if self.calculated_level > @level
                @level = calculated_level
                @hitpoints_remaining = @hitpoints_remaining + 5 + @hitpoints_modifier
                puts "Congratulations! #{@name} is now level #{@level}"
            end

            "Hit"
        else
            "Miss"
        end
    end
    def isDead
        @hitpoints_remaining == 0
    end
    def calculated_level
        1 + (@experience / 1000)
    end
    def hitpoints
        hitpoints = (5 + @hitpoints_modifier) * @level
        if hitpoints < 1 
            hitpoints = 1
        end

        hitpoints
    end
end

if __FILE__ == $0
    def set_character_name
        puts "What should my name be?"
        name = gets.strip
        puts "What should my alignment be?"
        puts "1 Good"
        puts "2 Evil"
        puts "3 Neutral"
        puts "Please enter alignment number."
        alignmentNumber = gets.strip

        if alignmentNumber == "1"
            alignment = "Good"
        elsif alignmentNumber == "2"
            alignment = "Evil"
        else
            alignment = "Neutral"
        end

        Character.create_character(name, alignment)
    end

    protagonist = set_character_name
    protagonist.describe_character

    antagonist = Character.create_character("#{protagonist.name}'s Evil twin", "Evil")
    loop do
            
        puts "What will you do?"
        action = gets.strip

        if action == "attack" || action == "a"
          if antagonist.isDead
              puts "#{antagonist.name} is dead. There is nothing else to do."
          else
            puts "What is your roll?"
            roll = gets.strip.to_i
            puts "You are attacking #{antagonist.name}."
            puts protagonist.attack(antagonist, roll)
            puts "#{antagonist.name} has #{antagonist.hitpoints_remaining} health remaining."
          end
        end

        if action == "quit"
            break
        end

    end
end