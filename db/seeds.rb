# create_table "users", force: :cascade do |t|
#   t.string "username"
#   t.string "email"
#   t.string "password_digest"
# end
katy = User.create(username: "katy", email: "katy@gmail.com", password:"123")
kevin = User.create(username: "kevin", email: "kevin@gmail.com", password:"123")
tanya = User.create(username: "tanya", email: "tanya@gmail.com", password:"123")

tanya.jobs << Job.create(title: "Junior Software Engineer", company: "Apple", location: "Cupertino, CA", description: "A job description goes here", applied: false)
katy.jobs << Job.create(title: "Software Engineer", company: "LinkedIn", location: "San Francisco, CA", description: "A job description goes here", applied: false)
kevin.jobs << Job.create(title: "Junior Software Engineer", company: "Flatiron School", location: "New York, NY", description: "A job description goes here", applied: true)
katy.jobs << Job.create(title: "Senior Software Engineer", company: "Google", location: "Cupertino, CA", description: "A job description goes here", applied: false)
katy.jobs << Job.create(title: "Full Stack Engineer", company: "Facebook", location: "Cupertino, CA", description: "A job description goes here", applied: false)
tanya.jobs << Job.create(title: "Web Developer", company: "Uber", location: "New York, NY", description: "A job description goes here", applied: true)
kevin.jobs << Job.create(title: "Front End Developer", company: "Twitch", location: "San Francisco, CA", description: "A job description goes here", applied: false)