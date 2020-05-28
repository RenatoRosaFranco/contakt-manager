# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'benchmark'
require 'faker'

puts "Start Running Seeds"

realtime = Benchmark.realtime do 

    # User
    User.destroy_all
    User.create(
      [
        {
          name: 'John Doe',
          email: 'johndoe@test.com',
          password: 'test123',
          password_confirmation: 'test123'
        }
      ]
    )

    john = User.last

    # Group
    Group.destroy_all
    Group.create(
      [
        { 
          name: 'Amigos', 
          user: john 
        },
        { 
          name: 'Clientes', 
          user: john 
        },
        { 
          name: 'Familia', 
          user: john 
        },
        { 
          name: 'Empresa', 
          user: john 
        }
      ]
    )

    # Contact
    Contact.destroy_all
    (1..20).each do |i|
    Contact.create({
      name: Faker::Name.name,
      email: Faker::Internet.email,
      company: Faker::Company.name, 
      phone: Faker::PhoneNumber.cell_phone,
      address: "#{Faker::Address.street_address} #{Faker::Address.zip} #{Faker::Address.city}",
      group: Group.all.sample,
      user: john
    }) 
  end
end

puts "Finished Running Seeds"
puts "Process time at #{Time.at(realtime.ceil)}"
