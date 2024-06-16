# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin_email = ENV['ADMIN_EMAIL']
admin_password = ENV['ADMIN_PASSWORD']

if admin_email && admin_password
  unless Admin.find_by(email: admin_email)
    Admin.create!(
      email: admin_email,
      password: admin_password,
      password_confirmation: admin_password
    )
    puts "Admin user created with email: #{admin_email}"
  else
    puts "Admin user already exists with email: #{admin_email}"
  end
else
  puts "Admin user creation skipped. Set ADMIN_EMAIL and ADMIN_PASSWORD environment variables."
end
