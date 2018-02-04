require './lscss/cli/messages'
require './lscss/cli/validation'
require './lscss/cli/helpers'

module LSCSS
  ##
  # class for command line interface
  class CLI
    include Messages
    include Validation
    include Helpers

    def initialize(args)
      @flags = find_flags(args)
      @args = args
      @input_file = nil
      @output_file = nil
    end

    def perform
      return puts_empty_flags if @flags.empty? and @args.empty?
      return puts_help if @flags.key?('h') or @flags.key?('help')
      return compile if @args[0] == 'compile'

      puts 'Undefined command. Use ./bin/lscss -h for help'
    end

    private

    # performing
    def compile
      set_files
      return nil unless valid_input?
      run_machine_and_save_to_file
    end

    def set_files
      @input_file = @args[1]
      @output_file = @args[2]
    end

    def run_machine_and_save_to_file
      output = run_machine
      save_to_file(output)
      nil
    end

    def run_machine
      File.open(@input_file, 'r') do |file|
        MainMachine.new(file.read).perform
      end
    end

    def save_to_file(output)
      @output_file += '.css' if @output_file.split('.').last != 'css'
      File.delete(@output_file) if File.exist?(@output_file)

      file = File.open(@output_file, 'w')
      file.puts output
      file.close
    end
  end
end
