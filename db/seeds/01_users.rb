print "#{pretty_print_name('Users')}\tStart: #{pretty_print(Time.now - @start_time)}"

def attach_default(user)
  if user.id == 5
    user.avatar.attach(io: File.open(Rails.root.join('db/images/default-avatar-1.jpg')),
                       filename: 'default-avatar-1.jpg',
                       content_type: 'image/jpeg')
  else
    user.avatar.attach(User.find(5).avatar.blob)
  end
end

unless User.find_by_email('philr@purpleriver.dev').present?
  user = User.create!(
    first_name: 'Phil',
    last_name: 'Reynolds',
    bio: Faker::Job.title,
    email: 'philr@purpleriver.dev',
    password: 'password',
    admin: true
  )
  user.avatar.attach(io: File.open(Rails.root.join('db/images/phil.jpg')),
                     filename: 'phil.jpg',
                     content_type: 'image/jpeg')
end

unless User.find_by_email('ieuan.skinner@swansea.ac.uk').present?
  user = User.create!(
    first_name: 'Ieuan',
    last_name: 'Skinner',
    bio: Faker::Job.title,
    email: 'ieuan.skinner@swansea.ac.uk',
    password: 'password',
    admin: true
  )
  user.avatar.attach(io: File.open(Rails.root.join('db/images/ieuan.jpg')),
                     filename: 'ieuan.jpg',
                     content_type: 'image/jpeg')
end

unless User.find_by_email('a.j.wing@swansea.ac.uk').present?
  user = User.create!(
    first_name: 'Alex',
    last_name: 'Wing',
    bio: Faker::Job.title,
    email: 'a.j.wing@swansea.ac.uk',
    password: 'password',
    admin: true
  )
  user.avatar.attach(io: File.open(Rails.root.join('db/images/alex.jpg')),
                     filename: 'alex.jpg',
                     content_type: 'image/jpeg')
end

unless User.find_by_email('g.d.andrews@swansea.ac.uk').present?
  user = User.create!(
    first_name: 'Gareth',
    last_name: 'Andrews',
    bio: Faker::Job.title,
    email: 'g.d.andrews@swansea.ac.uk',
    password: 'password',
    admin: true
  )
  user.avatar.attach(io: File.open(Rails.root.join('db/images/gareth.jpg')),
                     filename: 'gareth.jpg',
                     content_type: 'image/jpeg')
end

20.times.each do |index|
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    bio: Faker::Job.title,
    email: "AD-test-user-#{index + 1}@purpleriver.dev",
    password: 'test1234',
    admin: false
  )
  attach_default(user)
end

puts "\tDuration: #{pretty_print(Time.now - @start_time)}   Elapsed: #{pretty_print(Time.now - @start_time)}"
@last_time = Time.now
