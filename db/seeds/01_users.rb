print "#{pretty_print_name('Users')}\tStart: #{pretty_print(Time.now - @start_time)}"

IMAGES_DIR = Rails.root.join('db/images')

def attach(user, image)
  user.avatar.attach(io: File.open("#{IMAGES_DIR}/#{image}"), filename: image)
end

def attach_default(user)
  if user.id == 5
    attach(user, 'default-avatar-1.jpg')
  else
    user.avatar.attach(User.find(5).avatar.blob)
  end
end

def attach_image(user)
  attach(user, "#{user.first_name.downcase}.jpg")
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
  attach_image(user)
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
  attach_image(user)
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
  attach_image(user)
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
  attach_image(user)
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
