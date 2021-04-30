class Character
    attr_accessor :name
    attr_accessor :armor
    attr_accessor :hitpoints
    attr_accessor :strength_modifier

    def initialize(name, alignment, hitpoints = 5, strength = 10, dexterity = 10, constitution = 10, wisdom = 10, intelligence = 10, charisma = 10) 
        @name = name
        @alignment = alignment
        @armor = 10
        @hitpoints = hitpoints
        @strength = strength
        @dexterity = dexterity
        @constitution = constitution
        @wisdom = wisdom
        @intelligence = intelligence
        @charisma = charisma
        @strength_modifier = (@strength - 10)/2
    end
    def describe_character
        puts "Hi, I am #{@name}, a character with #{@alignment} alignment. I have #{@armor} armor and #{@hitpoints} hit points."
    end
    def attack(character, natural_roll)
        puts "You are attacking #{character.name}."
        roll = natural_roll + @strength_modifier
        if natural_roll == 20
            attack_damage = 2
            if attack_damage > character.hitpoints
                attack_damage = character.hitpoints
            end
            character.hitpoints = character.hitpoints - attack_damage
            return "Critical Hit"
        elsif roll >= character.armor
            attack_damage = 1 + @strength_modifier
            if attack_damage < 1
                attack_damage = 1
            end
            if attack_damage > character.hitpoints
                attack_damage = character.hitpoints
            end
            character.hitpoints = character.hitpoints - attack_damage
            return "Hit"
        else
            return "Miss"
        end
    end
    def isDead
        return @hitpoints == 0
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

        return Character.new(name, alignment)
    end

    protagonist = set_character_name
    protagonist.describe_character

    antagonist = Character.new("#{protagonist.name}'s Evil twin", "Evil")
    loop do
            
        puts "What will you do?"
        action = gets.strip

        if action == "attack"
            puts "What is your roll?" 
            roll = gets.strip.to_i
            puts protagonist.attack(antagonist, roll)
        end

        if action == "quit"
            break
        end

    end
end