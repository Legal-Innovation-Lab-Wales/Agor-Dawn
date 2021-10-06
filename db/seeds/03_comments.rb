print "#{pretty_print_name('Comments')}\tStart: #{pretty_print(Time.now - @start_time)}"

Project.all.each do |project|
  10.times do |index|
    comment = project.comments.create!(
      user_id: rand(1..User.count),
      comment_text: Faker::Company.catch_phrase
    )

    next unless (index % 3).zero?

    new_comment = project.comments.create!(
      user_id: comment.user_id,
      comment_text: Faker::Company.catch_phrase,
      replacing: comment
    )

    comment.update!(replaced_by: new_comment)
  end
end

puts "\tDuration: #{pretty_print(Time.now - @start_time)}   Elapsed: #{pretty_print(Time.now - @start_time)}"
@last_time = Time.now
