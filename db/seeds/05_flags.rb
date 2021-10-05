if Flag.count.zero?
  print "#{pretty_print_name('Flags')}\tStart: #{pretty_print(Time.now - @start_time)}"

  Flag.skip_callback(:create, :after, :mail_user)

  Project.all.each do |project|
    next unless (project.id % 5).zero?

    Flag.create!(
      flagged_by: User.admins.order('RANDOM()').first,
      reason: "Admin: #{Faker::TvShows::TheITCrowd.quote}",
      flaggable: project
    )
  end

  Flag.set_callback(:create, :after, :mail_user)

  puts "\tDuration: #{pretty_print(Time.now - @start_time)}   Elapsed: #{pretty_print(Time.now - @start_time)}"
  @last_time = Time.now
end
