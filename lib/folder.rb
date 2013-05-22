require "folder/version"

module Folder
  DEFAULT_SEPARATOR = '.'.freeze

  def fold!(separator = DEFAULT_SEPARATOR)
    klass  = self.class
    folded = klass.new

    each do |key, value|
      next unless key.is_a?(String) and key.include?(separator)

      keys = key.split(separator, -1)
      last = keys.pop

      current = keys.reduce(folded) {|memo, item|
        memo[item].is_a?(klass) ?
          memo[item] : (memo[item] = klass.new)
      }

      current[last] = value unless current[last].is_a?(klass)
      delete key
    end

    merge! folded
  end

  def fold(separator = DEFAULT_SEPARATOR)
    dup.fold! separator
  end
end

Hash.__send__(:include, Folder)

