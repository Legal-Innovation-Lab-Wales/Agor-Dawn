print "#{pretty_print_name('Projects')}\tStart: #{pretty_print(Time.now - @start_time)}"

while Project.count != 10
  Project.create!(
    user_id: rand(1..User.count),
    name: Faker::Company.name,
    description: Faker::Markdown.sandwich(sentences: 65),
    summary: Faker::Company.catch_phrase,
    public: true,
    view_count: 0,
    num_likes: rand(1..10)
  )
end

puts "\tDuration: #{pretty_print(Time.now - @start_time)}   Elapsed: #{pretty_print(Time.now - @start_time)}"
@last_time = Time.now