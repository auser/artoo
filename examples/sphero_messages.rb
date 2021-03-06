require 'artoo'

connection :sphero, :adaptor => :sphero, :port => '4567' #'/dev/tty.Sphero-BWY-RN-SPP'
device :sphero, :driver => :sphero
  
work do
  puts "Configuring..."
  sphero.configure_collision_detection 0x01, 0x20, 0x20, 0x20, 0x20, 0x50

  every(3.seconds) do
    puts "Rolling..."
    sphero.roll 60, rand(360)
    unless sphero.collisions.empty?
      puts "----------"
      sphero.collisions.each do |c|
        puts c
      end
      puts "=========="
      sphero.async_messages.clear
    end
  end
end