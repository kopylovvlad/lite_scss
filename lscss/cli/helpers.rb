module Helpers
  private

  def find_flags(args)
    Hash[args.flat_map { |s| s.scan(/--?([^=\s]+)(?:=(\S+))?/) }]
  end
end
