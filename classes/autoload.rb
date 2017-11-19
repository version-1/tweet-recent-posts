files = Dir.glob("./classes/*.rb")

files.each do |val|
    require val
end
