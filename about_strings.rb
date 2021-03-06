require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutStrings < Neo::Koan
  def test_double_quoted_strings_are_strings
    string = "Hello, World"
    # Check the class of string with .is_a?
    #   .is_a?(class) -> true or false
    assert_equal true, string.is_a?(String)
  end

  def test_single_quoted_strings_are_also_strings
    string = 'Goodbye, World'
    assert_equal true, string.is_a?(String)
  end

  def test_use_single_quotes_to_create_string_with_double_quotes
    string = 'He said, "Go Away."'
    # assert_equal compares the two arguments and returns true or false
    assert_equal "He said, \"Go Away.\"", string
  end

  def test_use_double_quotes_to_create_strings_with_single_quotes
    string = "Don't"
    assert_equal "Don't", string
  end

  def test_use_backslash_for_those_hard_cases
    a = "He said, \"Don't\""
    b = 'He said, "Don\'t"'
    assert_equal true, a == b
  end

  def test_use_flexible_quoting_to_handle_really_hard_cases
    a = %(flexible quotes can handle both ' and " characters)
    b = %!flexible quotes can handle both ' and " characters!
    c = %{flexible quotes can handle both ' and " characters}
    assert_equal true, a == b
    assert_equal true, a == c
  end

  def test_flexible_quotes_can_handle_multiple_lines
    long_string = %{
It was the best of times,
It was the worst of times.
}
    # String.length returns an integer representing the length of String
    assert_equal 54, long_string.length
    # String.lines(separator=$/) -> an_array
    #   Returns an array of lines in str split using the supplied record separator ($/ by default).  This s a shorthand for str.each_line(separator).to_a.
    # Array.count(obj) -> int
    #   Returns the number of elements
    assert_equal 3, long_string.lines.count
    assert_equal "\n", long_string[0,1]
  end

  def test_here_documents_can_also_handle_multiple_lines
    # The following is called a "here document".
    #   Construct a here document using the << operator followed by an identifier that marks the end of the here document.  The end mark is called the terminator.

    # puts <<GROCERY_LIST
    # Grocery list
    # ------------
    # 1. Salad mix.
    # 2. Strawberries.*
    # 3. Cereal.
    # 4. Milk.*

    # * Organic
    # GROCERY_LIST
    # The result:

    # $ grocery-list.rb
    # Grocery list
    # ------------
    # 1. Salad mix.
    # 2. Strawberries.*
    # 3. Cereal.
    # 4. Milk.*

    # * Organic

    # Read more here: https://en.wikibooks.org/wiki/Ruby_Programming/Here_documents

    long_string = <<EOS
It was the best of times,
It was the worst of times.
EOS
    
    assert_equal 53, long_string.length
    assert_equal 2, long_string.lines.count
    # String#[]
    #   str[start, length]
    assert_equal "I", long_string[0,1]
  end

  def test_plus_will_concatenate_two_strings
    string = "Hello, " + "World"
    assert_equal "Hello, World", string
  end

  def test_plus_concatenation_will_leave_the_original_strings_unmodified
    hi = "Hello, "
    there = "World"
    string = hi + there
    assert_equal "Hello, ", hi
    assert_equal "World", there
    # I added the following assertion on the assumption that string was meant to be tested
    assert_equal "Hello, World", string
  end

  def test_plus_equals_will_concatenate_to_the_end_of_a_string
    hi = "Hello, "
    there = "World"
    hi += there
    assert_equal "Hello, World", hi
  end

  def test_plus_equals_also_will_leave_the_original_string_unmodified
    original_string = "Hello, "
    hi = original_string
    there = "World"
    hi += there
    assert_equal "Hello, ", original_string
  end

  def test_the_shovel_operator_will_also_append_content_to_a_string
    hi = "Hello, "
    there = "World"
    # String#<<
    #   str << obj ->
    #   Append-Concatenates the given object to str.
    hi << there
    assert_equal "Hello, World", hi
    assert_equal "World", there
  end

  def test_the_shovel_operator_modifies_the_original_string
    original_string = "Hello, "
    hi = original_string
    there = "World"
    hi << there
    assert_equal "Hello, World", original_string

    # THINK ABOUT IT:
    #
    # Ruby programmers tend to favor the shovel operator (<<) over the
    # plus equals operator (+=) when building up strings.  Why?
  end

  def test_double_quoted_string_interpret_escape_characters
    string = "\n"
    # String#size
    #   size -> integer
    #   Returns the character length of str
    assert_equal 1, string.size
  end

  def test_single_quoted_string_do_not_interpret_escape_characters
    string = '\n'
    assert_equal 2, string.size
  end

  def test_single_quotes_sometimes_interpret_escape_characters
    string = '\\\''
    assert_equal 2, string.size
    assert_equal "\\'", string
  end

  def test_double_quoted_strings_interpolate_variables
    value = 123
    string = "The value is #{value}"
    assert_equal "The value is 123", string
  end

  def test_single_quoted_strings_do_not_interpolate
    value = 123
    string = 'The value is #{value}'
    assert_equal 'The value is #{value}', string
  end

  def test_any_ruby_expression_may_be_interpolated
    # Math.sqrt(a)
    #   Computes the square root of a.
    string = "The square root of 5 is #{Math.sqrt(5)}"
    assert_equal "The square root of 5 is 2.23606797749979", string
  end

  def test_you_can_get_a_substring_from_a_string
    string = "Bacon, lettuce and tomato"
    # string[x,y]
    #   y spaces from the x index
    assert_equal "let", string[7,3]
    # string[x..y]
    #   From the x index to the y index
    assert_equal "let", string[7..9]
  end

  def test_you_can_get_a_single_character_from_a_string
    string = "Bacon, lettuce and tomato"
    assert_equal "a", string[1]

    # Surprised?
  end

  # Following code does not run, Ruby version 1.8 is not installed.
  in_ruby_version("1.8") do
    def test_in_older_ruby_single_characters_are_represented_by_integers
      assert_equal __, ?a
      assert_equal __, ?a == 97

      assert_equal __, ?b == (?a + 1)
    end
  end

  # Following code runs
  in_ruby_version("1.9", "2") do
    def test_in_modern_ruby_single_characters_are_represented_by_strings
      assert_equal "a", ?a
      assert_equal false, ?a == 97
    end
  end

  def test_strings_can_be_split
    string = "Sausage Egg Cheese"
    # String#split(pattern=nil, [limit]) -> anArray
    #   Divides str into substrings based on a delimiter, returning an array of these substrings.  If pattern is a string then it's contents are used as the delimiter when splitting str.
    words = string.split
    assert_equal ["Sausage", "Egg", "Cheese"], words
  end

  def test_strings_can_be_split_with_different_patterns
    string = "the:rain:in:spain"
    words = string.split(/:/)
    assert_equal ["the", "rain", "in", "spain"], words

    # NOTE: Patterns are formed from Regular Expressions.  Ruby has a
    # very powerful Regular Expression library.  We will become
    # enlightened about them soon.
  end

  def test_strings_can_be_joined
    words = ["Now", "is", "the", "time"]
    # Array#join(sepearator=$,) -> str
    #   Returns a string created by converting each element of the array to a string, separated by the given separator.
    assert_equal "Now is the time", words.join(" ")
  end

  def test_strings_are_unique_objects
    a = "a string"
    b = "a string"

    # Object#object_id -> integer
    #   Returns an integer identifier for obj.
    assert_equal true, a           == b
    assert_equal false, a.object_id == b.object_id
  end
end
