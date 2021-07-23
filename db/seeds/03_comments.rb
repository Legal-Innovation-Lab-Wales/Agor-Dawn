print "#{pretty_print_name('Comments')}\tStart: #{pretty_print(Time.now - @start_time)}"

Project.all.each do |project|
  10.times do
    Comment.create!(
     user_id: rand(1..User.count),
     project: project,
     comment: Faker::Company.catch_phrase,
    )
  end
end

puts "\tDuration: #{pretty_print(Time.now - @start_time)}   Elapsed: #{pretty_print(Time.now - @start_time)}"
@last_time = Time.now