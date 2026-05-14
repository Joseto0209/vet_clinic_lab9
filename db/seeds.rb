Treatment.destroy_all
Appointment.destroy_all
Pet.destroy_all
Vet.destroy_all
Owner.destroy_all
User.destroy_all

puts "Creating users..."
User.create!(first_name: "Admin", last_name: "User", email: "admin@vetclinic.cl", password: "password123", role: :admin)
User.create!(first_name: "Vet", last_name: "User", email: "vet@vetclinic.cl", password: "password123", role: :vet)
User.create!(first_name: "Owner", last_name: "User", email: "owner@vetclinic.cl", password: "password123", role: :owner)

puts "Creating owners..."
owner1 = Owner.create!(first_name: "Matías", last_name: "González", email: "matias.g@gmail.com", phone: "+56912345678", address: "Av. Bicentenario 3800, Vitacura")
owner2 = Owner.create!(first_name: "Isidora", last_name: "Undurraga", email: "isi.u@hotmail.com", phone: "+56987654321", address: "Av. San Martín 450, Viña del Mar")
owner3 = Owner.create!(first_name: "Diego", last_name: "Tapia", email: "diego.t@yahoo.cl", phone: "+56955555555", address: "Barrio República, Santiago")

puts "Registering pets..."
pet1 = owner1.pets.create!(name: "Cachupín", species: "dog", breed: "Mixed Breed", date_of_birth: Date.new(2019, 9, 18), weight: 15.5)
pet2 = owner1.pets.create!(name: "Pelusa", species: "dog", breed: "Toy Poodle", date_of_birth: Date.new(2021, 4, 12), weight: 4.2)
pet3 = owner2.pets.create!(name: "Cucho", species: "cat", breed: "Domestic Shorthair", date_of_birth: Date.new(2020, 8, 1), weight: 5.8)
pet4 = owner3.pets.create!(name: "Guatón", species: "dog", breed: "English Bulldog", date_of_birth: Date.new(2018, 12, 25), weight: 25.0)
pet5 = owner2.pets.create!(name: "Tambo", species: "rabbit", breed: "Angora", date_of_birth: Date.new(2022, 3, 15), weight: 2.1)

pet1.photo.attach(io: File.open(Rails.root.join('db', 'seeds', 'pets', 'dog1.jpg')), filename: 'dog1.jpg', content_type: 'image/jpeg')
pet2.photo.attach(io: File.open(Rails.root.join('db', 'seeds', 'pets', 'dog2.jpg')), filename: 'dog2.jpg', content_type: 'image/jpeg')
pet3.photo.attach(io: File.open(Rails.root.join('db', 'seeds', 'pets', 'cat1.jpg')), filename: 'cat1.jpg', content_type: 'image/jpeg')
pet4.photo.attach(io: File.open(Rails.root.join('db', 'seeds', 'pets', 'dog3.jpg')), filename: 'dog3.jpg', content_type: 'image/jpeg')
pet5.photo.attach(io: File.open(Rails.root.join('db', 'seeds', 'pets', 'rabbit1.jpg')), filename: 'rabbit1.jpg', content_type: 'image/jpeg')

puts "Creating veterinarians..."
vet1 = Vet.create!(first_name: "Javiera", last_name: "Soto", email: "jsoto@veterinaria.cl", phone: "+56911112222", specialization: "General Medicine")
vet2 = Vet.create!(first_name: "Rodrigo", last_name: "Pérez", email: "rperez@veterinaria.cl", phone: "+56933334444", specialization: "Surgery and Traumatology")

puts "Scheduling appointments..."
app1 = Appointment.create!(pet: pet1, vet: vet1, date: Time.current - 2.days, reason: "Ate a sausage at the barbecue", status: :completed)
app2 = Appointment.create!(pet: pet3, vet: vet2, date: Time.current - 1.day, reason: "Fight on the roof with other cats", status: :completed)
app3 = Appointment.create!(pet: pet4, vet: vet1, date: Time.current, reason: "Breathing problems due to heat", status: :in_progress)
app4 = Appointment.create!(pet: pet2, vet: vet1, date: Time.current + 3.days, reason: "Routine checkup and vaccinations", status: :scheduled)
app5 = Appointment.create!(pet: pet5, vet: vet2, date: Time.current - 5.days, reason: "Paw examination", status: :cancelled)

puts "Applying medical treatments..."
Treatment.create!(appointment: app1, name: "Gastric Lavage", medication: "Activated Charcoal", dosage: "20 ml", clinical_notes: "<h1>Emergency</h1><p>The dog is fine, but no more <em>sausages</em> for a while.</p><ul><li>Recovered from indigestion</li><li>Needs rest</li></ul>", administered_at: Time.current - 2.days)
Treatment.create!(appointment: app1, name: "Hydration", medication: "Saline Solution", dosage: "500 ml", clinical_notes: "<p>Administered <strong>IV fluids</strong> for stabilization.</p>", administered_at: Time.current - 2.days)
Treatment.create!(appointment: app2, name: "Ear Suture", medication: "Local Anesthesia and Povidone", dosage: "3 stitches", clinical_notes: "<p>Cucho lost the fight, but the suture turned out great.</p>", administered_at: Time.current - 1.day)
Treatment.create!(appointment: app2, name: "Antibiotic", medication: "Amoxicillin", dosage: "1 pill every 12h", clinical_notes: "<p>To prevent infection</p>", administered_at: Time.current - 1.day)
Treatment.create!(appointment: app3, name: "Oxygen Therapy", medication: "Oxygen", dosage: "15 min", clinical_notes: "<h1>Recovery</h1><p>Guatón is already breathing better.</p>", administered_at: Time.current)

puts "Database seeded successfully!"