module Validation
  private

  def valid_input?
    if args_exist? and valid_input_format? and input_file_exist?
      true
    else
      false
    end
  end

  def args_exist?
    if args_are_empty?
      puts 'Error: set input and output file'
      puts 'You can use "-h" or "--help" for info'
      return false
    end

    true
  end

  def args_are_empty?
    (@input_file.nil? or @output_file.nil? or
      @input_file.empty? or @output_file.empty?)
  end

  def valid_input_format?
    return true if @input_file.split('.').last == 'lscss'

    puts 'Input file must be .lscss format'
    puts 'You can use "-h" or "--help" for info'
    false
  end

  def input_file_exist?
    return true if File.exist?(@input_file)

    puts 'Input file must exists'
    puts 'You can use "-h" or "--help" for info'
    false
  end
end
