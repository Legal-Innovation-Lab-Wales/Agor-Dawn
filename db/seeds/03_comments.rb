print "#{pretty_print_name('Comments')}\tStart: #{pretty_print(Time.now - @start_time)}"

while Comment.count != 10
  Comment.create!(
    user_id: rand(1..User.count-1),
    project_id: rand(1..Project.count-1),
    description: Faker::Company.catch_phrase,
  )
end

puts "\tDuration: #{pretty_print(Time.now - @start_time)}   Elapsed: #{pretty_print(Time.now - @start_time)}"
@last_time = Time.now