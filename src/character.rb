class Character
    attr_accessor :name
    attr_accessor :armor
    attr_accessor :strength_modifier
    attr_accessor :armor_modifier
    attr_accessor :hitpoints_modifier
    attr_accessor :experience
    attr_accessor :hitpoints_remaining

    def self.with_strength(name, alignment, strength)
        new(name, alignment, 5, strength)
    end

    def self.with_dexterity(name, alignment, dexterity)
        new(name, alignment, 5, 10, dexterity)
    end

    def self.with_constitution(name, alignment, constitution)
        new(name, alignment, 5, 10, 10, constitution)
    end

    def self.with_experience(name, alignment, experience)
        new(name, alignment, 5, 10, 10, 10, 10, 10, 10, experience)
    end
    
    def initialize(name, alignment, hitpoints = 5, strength = 10, dexterity = 10, constitution = 10, wisdom = 10, intelligence = 10, charisma = 10, experience = 0) 
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
        @hitpoints_remaining = self.hitpoints
    end
    def describe_character
        puts "Hi, I am #{@name}, a character with #{@alignment} alignment. I have #{@armor} armor and #{@hitpoints} hit points."
    end
    def attack(character, natural_roll)
        puts "You are attacking #{character.name}."
        roll = natural_roll + @strength_modifier + (self.level / 2)
        if natural_roll == 20
            attack_damage = 2
            if attack_damage > character.hitpoints_remaining
                attack_damage = character.hitpoints_remaining
            end
            character.hitpoints_remaining = character.hitpoints_remaining - attack_damage
            @experience  = @experience + 10
            return "Critical Hit"
        elsif roll >= character.armor
            attack_damage = 1 + @strength_modifier
            if attack_damage < 1
                attack_damage = 1
            end
            if attack_damage > character.hitpoints_remaining
                attack_damage = character.hitpoints_remaining
            end
            character.hitpoints_remaining = character.hitpoints_remaining - attack_damage
            @experience  = @experience + 10
            return "Hit"
        else
            return "Miss"
        end
    end
    def isDead
        return @hitpoints_remaining == 0
    end
    def level
        return 1 + (@experience / 1000)
    end
    def hitpoints
        hitpoints = (5 * self.level) + @hitpoints_modifier
        if hitpoints < 1 
            hitpoints = 1
        end

        return hitpoints
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