
class LineAnalyzer
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_count = 0
    calculate_word_frequency
  end

  def calculate_word_frequency()
    @highest_wf_words = Hash.new
    words = @content.split
    words.each do |word|
      if @highest_wf_words.has_key?(word)
        @highest_wf_words[word] += 1
      else
        @highest_wf_words[word] = 1
      end
    end
    @highest_wf_words.sort_by { |word, count| count }
    @highest_wf_words.each do |key, value|
      if value > @highest_wf_count
        @highest_wf_count = value
      end
    end
  end
end

class Solution
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = []
  end

  def analyze_file
    count = 0
    File.foreach('test.txt') do |line|
      @analyzers.push(LineAnalyzer.new(line, count += 1))
    end
  end

  def calculate_line_with_highest_frequency()
    @highest_count_across_lines = 0
    @highest_count_words_across_lines = []
    @analyzers.each do |analyzer|
      if analyzer.highest_wf_count > @highest_count_across_lines
        @highest_count_across_lines = analyzer.highest_wf_count
      end
      analyzer.highest_wf_words.each do |key, value|
        @highest_count_words_across_lines << key
      end
    end
  end

  def print_highest_word_frequency_across_lines
    puts "The following words have the highest word frequency per line: #{@highest_count_words_across_lines}."
  end
end
