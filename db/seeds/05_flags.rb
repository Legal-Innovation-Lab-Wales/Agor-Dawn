if Flag.count.zero?
  print "#{pretty_print_name('Flags')}\tStart: #{pretty_print(Time.now - @start_time)}"

  Project.all.each do |project|
    next unless (project.id % 5).zero?

    Flag.create!(
      user_id: User.where(admin: true).order('RANDOM()').first.id,
      reason: Faker::TvShows::TheITCrowd.quote,
      flaggable: project
    )
  end

  Comment.all.each do |comment|
    next unless (comment.id % 5).zero?

    Flag.create!(
      user_id: User.where(admin: true).order('RANDOM()').first.id,
      reason: Faker::TvShows::TheITCrowd.quote,
      flaggable: comment
    )
  end

  puts "\tDuration: #{pretty_print(Time.now - @start_time)}   Elapsed: #{pretty_print(Time.now - @start_time)}"
  @last_time = Time.now
end
