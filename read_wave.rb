def read_wave(file_name, mode)
  wave ||= []
  File.open("./data/"+ file_name) {|file|
    if mode == 's'
      binary = file.read
      wave = binary.unpack('s*')

    elsif mode == 'd'
      binary = file.read
      wave = binary.unpack('d*') #d* は符号付きの浮動小数点を指定

    elsif mode == "text"
      file.each{|line|
        wave << line.chomp.to_f
      }
    end
  }
  return wave
end

