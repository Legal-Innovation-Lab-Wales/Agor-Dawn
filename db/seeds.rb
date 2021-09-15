require 'faker'

@start_time = Time.now

MAX_NAME_LENGTH = 22
MAX_TIME_LENGTH = 6
DOTTED_LINE_LENGTH = MAX_NAME_LENGTH + (MAX_TIME_LENGTH * 3) +
                     ('Start: '.length + 'Duration: '.length + 'Elapsed: '.length) + 8 # Tabs

def pretty_print_name(name)
  name = name[0..(MAX_NAME_LENGTH - 1)] if name.length > MAX_NAME_LENGTH
  name + (' ' * (MAX_NAME_LENGTH - name.length))
end

def pretty_print(value)
  str = value.to_f.to_s
  if str.length < MAX_TIME_LENGTH
    str + ('0' * (MAX_TIME_LENGTH - str.length))
  else
    str[0..(MAX_TIME_LENGTH - 1)]
  end
end

# Clear Local ActiveStorage
FileUtils.rm_rf(Rails.root.join('storage'))

puts ('-' * DOTTED_LINE_LENGTH).to_s
puts 'Running Seeds'
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }

puts ('-' * DOTTED_LINE_LENGTH).to_s
puts 'Counts'
puts("#{pretty_print_name('Users')}\t#{User.count}")
puts("#{pretty_print_name('Projects')}\t#{Project.count}")
puts("#{pretty_print_name('Comments')}\t#{Comment.count}")
puts("#{pretty_print_name('Likes')}\t#{Like.count}")
puts("#{pretty_print_name('Flags')}\t#{Flag.count}")
