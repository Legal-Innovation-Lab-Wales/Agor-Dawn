if Flag.count.zero?
  print "#{pretty_print_name('Flags')}\tStart: #{pretty_print(Time.now - @start_time)}"

  Project.all.each do |project|
    next unless (project.id % 5).zero?

    Flag.create!(
      flagged_by: User.where(admin: true).order('RANDOM()').first,
      reason: "Admin: #{Faker::TvShows::TheITCrowd.quote}",
      flaggable: project
    )
  end

  puts "\tDuration: #{pretty_print(Time.now - @start_time)}   Elapsed: #{pretty_print(Time.now - @start_time)}"
  @last_time = Time.now
end
