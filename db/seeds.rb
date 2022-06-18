# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def create_user(args)
    user = User.create(args)
end

def create_modality(args)
    capacity = Capacity.create(args)
end

def create_classroom(args)
    classroom = Classroom.create(args)
end

User.delete_all
puts "Creating Users"
create_user(
    name: "Gustavo",
    last_name: "Ferreira",
    email: "gustavo.ferreira@injunior.com.br",
    password: "123",
    password_confirmation: "123",
    profile_picture_link: "teste"
    role: 1
)

Capacity.delete_all
puts "Creating capacities"
modalities = ["Karatê", "jiu-jitsu", "krav maga", "zumba", "muay thai", "boxe")]
modalities.each do |t|
    create_modality(name: t)
end

Classroom.delete_all
create_classroom(
    name: "turma do gustavao"
)