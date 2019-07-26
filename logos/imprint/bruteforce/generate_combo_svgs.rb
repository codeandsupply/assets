#!/usr/bin/env ruby
require 'pp'
require 'erb'


# rejections
all_same = {name: :all_same, logic: Proc.new { |perm| perm.uniq.count == 1 } }

characters_different = {name: :characters_different, logic: Proc.new {|perm| perm.slice(2, 3).uniq.size != 1 } }

characters_same_as_background = {name: :characters_same_as_background, logic: Proc.new {|perm| perm[0] == perm.slice(2,3).uniq.first } }

colors = [:black, :white, :red]
hex = { black: '#000', white: '#fff', red: '#b22d00' }

all_permutations = colors.repeated_permutation(5)
STDERR.puts "#{all_permutations.size} perms total"

valid_permutations = all_permutations.reject do |perm|
  rejection_rules = [
    all_same,
    characters_different,
    characters_same_as_background
  ]
  
  rejections = rejection_rules.map do |f|
    {name: f[:name], result: f[:logic].call(perm)}
  end
  rejections.map{|r|r[:result]}.any?
end
STDERR.puts "#{valid_permutations.size} perms valid"

pp valid_permutations

template = ERB.new(File.open('cs_imprint_paths.svg.erb').read)

valid_permutations.each do |perm|
  filename = "build/cs_imprint_basic_#{perm[0]}-bg_#{perm[1]}-border_#{perm[2]}-lettering.svg"
  color_shield_bg = hex[perm[0]]
  color_shield_stroke = hex[perm[1]]
  color_c = hex[perm[2]]
  color_ampersand = hex[perm[3]]
  color_s = hex[perm[4]]
  File.open(filename, 'w+') do |f|
    f.write(template.result(binding))
  end
end
