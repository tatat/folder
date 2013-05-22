require "folder/version"

module Folder
  DEFAULT_SEPARATOR = '.'.freeze

  def fold!(separator = DEFAULT_SEPARATOR)
    klass = self.class
    temp  = klass.new

    each do |key, value|
      next unless key.is_a?(String) and key.index(separator)

      *keys, last = key.split(separator, -1)
      current     = temp

      while keys.length != 0
        k          = keys.shift
        current[k] = klass.new unless current[k].is_a?(klass)
        current    = current[k]
      end

      current[last] = value unless current[last].is_a?(klass)
      delete key
    end

    merge! temp
  end

  def fold(separator = DEFAULT_SEPARATOR)
    dup.fold! separator
  end
end

class Hash
  include Folder
end

