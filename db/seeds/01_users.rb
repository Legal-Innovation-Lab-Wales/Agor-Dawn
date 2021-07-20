print "#{pretty_print_name('Users')}\tStart: #{pretty_print(Time.now - @start_time)}"

unless User.find_by_email('philr@purpleriver.dev').present?
  User.create!(
    first_name: 'Phil',
    last_name: 'Reynolds',
    bio: Faker::Job.title,
    email: 'philr@purpleriver.dev',
    password: 'password',
    admin: true
  )
end

unless User.find_by_email('ieuan.skinner@swansea.ac.uk').present?
  User.create!(
    first_name: 'Ieuan',
    last_name: 'Skinner',
    bio: Faker::Job.title,
    email: 'ieuan.skinner@swansea.ac.uk',
    password: 'password',
    admin: true
  )
end

unless User.find_by_email('a.j.wing@swansea.ac.uk').present?
  User.create!(
    first_name: 'Alex',
    last_name: 'Wing',
    bio: Faker::Job.title,
    email: 'a.j.wing@swansea.ac.uk',
    password: 'password',
    admin: true
  )
end

unless User.find_by_email('g.d.andrews@swansea.ac.uk').present?
  User.create!(
    first_name: 'Gareth',
    last_name: 'Andrews',
    bio: Faker::Job.title,
    email: 'g.d.andrews@swansea.ac.uk',
    password: 'password',
    admin: true
  )
end

puts "\tDuration: #{pretty_print(Time.now - @start_time)}   Elapsed: #{pretty_print(Time.now - @start_time)}"
@last_time = Time.now
