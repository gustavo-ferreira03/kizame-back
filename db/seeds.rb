# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# User.delete_all
# Modality.delete_all
# Classroom.delete_all

def create_modality(args)
    modality = Modality.create(args)
end

def create_user(modality=Modality.all.sample.id, args)
    user = User.new(args)
    modality = user.build_user_modality(modality_id: modality)

    User.transaction do
        user.save!
        modality.save!
    end
end

def create_classroom(args)
    instructor = User.where(role: "instructor").sample
    classroom = Classroom.new(args)
    modality = classroom.build_classroom_modality(modality_id: Modality.all.sample.id)
    schedule = classroom.build_schedule(
        from_time: 12,
        to_time: 13,
        from_weekday: 1,
        to_weekday: 5
    )

    Modality.transaction do
        classroom.save!
        modality.save!
        schedule.save!
        classroom.members.append(instructor)
    end
end

puts "Creating modalities"
modalities_list = ["Karatê", "jiu-jitsu", "krav maga", "zumba", "muay thai", "boxe"]
modalities_list.each { |t| create_modality(name: t) }

puts "Creating Users"
create_user(
    1,
    name: "Gustavo",
    last_name: "F",
    email: "gustavo.ferreira@gmail.com.br",
    password: "123",
    password_confirmation: "123",
    profile_picture_link: "teste",
    role: 0
)

create_user(
    1,
    name: "Gustavo",
    last_name: "Ferreira",
    email: "gustavo.ferreira@injunior.com.br",
    password: "123",
    password_confirmation: "123",
    profile_picture_link: "teste",
    role: 1
)

create_user(
    name: "Gustavo",
    last_name: "Cosme",
    email: "gustavo.ferreira@admin.com.br",
    password: "123",
    password_confirmation: "123",
    profile_picture_link: "teste",
    role: 2
)

puts "  Creating students"
5.times do
    create_user(
        name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: "123",
        password_confirmation: "123",
        profile_picture_link: "teste",
        role: 0
    )
end

puts "  Creating instructors"
5.times do
    create_user(
        name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: "123",
        password_confirmation: "123",
        profile_picture_link: "teste",
        role: 1
    )
end

puts "Creating classrooms"
10.times do
    create_classroom(name: "Turma #{rand(0..300)}")
end