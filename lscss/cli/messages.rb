module Messages
  private

  def puts_empty_flags
    puts 'Welcome to LSCSS command line interface'
    puts 'You can use "-h" or "--help" for info'
  end

  def puts_help
    puts 'Usage:'
    puts ''
    puts './bin/lscss -h        # see help'
    puts './bin/lscss --help    # see help'
    puts './bin/lscss compile input_file.lscss output_file  # compile lscss file to css'
  end
end
