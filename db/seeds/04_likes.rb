print "#{pretty_print_name('Likes')}\tStart: #{pretty_print(Time.now - @start_time)}"

Project.all.each { |project| User.all.each { |user| Like.create!(user: user, project: project) } }

puts "\tDuration: #{pretty_print(Time.now - @start_time)}   Elapsed: #{pretty_print(Time.now - @start_time)}"
@last_time = Time.now
