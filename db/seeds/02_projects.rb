print "#{pretty_print_name('Projects')}\tStart: #{pretty_print(Time.now - @start_time)}"

10.times.each do
  Project.create!(
    user_id: rand(1..User.count),
    name: Faker::Company.name,
    content: Faker::Markdown.random,
    summary: Faker::Company.catch_phrase,
    public: true,
    view_count: 0
  )
end

puts "\tDuration: #{pretty_print(Time.now - @start_time)}   Elapsed: #{pretty_print(Time.now - @start_time)}"
@last_time = Time.now
