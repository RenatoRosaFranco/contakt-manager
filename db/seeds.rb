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
          name: '',
          email: '',
          password: '',
          password_confirmation: ''
        }
      ]
    )

    # Group
    Group.destroy_all
    Group.create(
      [
        { name: 'Amigos' },
        { name: 'Clientes' },
        { name: 'Familia' }
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
    }) 
  end
end

puts "Finished Running Seeds"

puts "Process time at #{Time.at(realtime.ceil)}"
