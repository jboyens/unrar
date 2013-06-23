require "unrar/version"
require 'fileutils'
require 'tmpdir'

module Unrar
  class Archive
    SEARCH_PATH = ["/usr/local/bin", "/usr/bin", "/bin", "/opt/local/bin"]

    attr_accessor :file, :tmpdir

    def initialize(file)
      self.file = file
      self.tmpdir = Dir.mktmpdir

      # shitty clean up; fix this
      at_exit {
        FileUtils.rm_rf self.tmpdir
      }

      unless File.readable? file
        raise "Cannot read #{file}!"
      end
    end

    def extract filename, *filenames
      `#{Archive.unrar} -y x #{self.file} #{filename} #{filenames.join(" ")} #{tmpdir}/`

      Dir["#{tmpdir}/**/*"].to_ary
    end

    def list
      items = []
      cmdoutput = `#{Archive.unrar} lb #{self.file}`
      cmdoutput.each_line do |line|
        items << line
      end
      return items
    end
    def self.unrar
      @@unrar ||= search_for "unrar"
    end

    private

    def self.search_for file
      SEARCH_PATH.find do |path|
        return "#{path}/#{file}" if File.exists? "#{path}/#{file}"
      end
    end
  end
end
