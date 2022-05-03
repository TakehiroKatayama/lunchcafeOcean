User.create!(name: '管理者', email: 'admin@example.com', phonenumber: '0700000000', password: 'test1111', password_confirmation: 'test1111', role: 1)
puts '管理者のテストデータ挿入'

1000.times do |i|
  date = Date.today + i
end
puts 'Capacityのテストデータ挿入'

1000.times { |i| Capacity.create(start_time: Date.today + i) }
