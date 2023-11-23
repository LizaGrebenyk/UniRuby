# frozen_string_literal: true

# Class HTMLGenerator for dynamically generating HTML content
class HTMLGenerator
  # Initializes an HTMLGenerator instance
  # The instance variable @html holds the generated HTML content
  # The provided block is evaluated within the instance's context
  def initialize(&block)
    @html = String.new
    instance_eval(&block)
  end

  # Handles undefined method calls to create HTML tags dynamically
  # Differentiates between self-closing tags and regular tags
  def method_missing(name, *args, &block)
    attributes, content = parse_args(args)

    if self_closing_tag?(name)
      @html << "<#{name}#{format_attributes(attributes)}/>"
    else
      @html << "<#{name}#{format_attributes(attributes)}>"
      @html << content
      instance_eval(&block) if block_given?
      @html << "</#{name}>"
    end
  end

  # Specialized method for adding paragraph tags
  def p(content = "", **attributes, &block)
    add_tag(:p, content, attributes, &block)
  end

  # Returns the generated HTML content as a string
  def to_s
    @html
  end

  # Saves the generated HTML content to a file
  def save_to_file(filename)
    File.open(filename, "w") do |file|
      file.write(to_s)
    end
  end

  private

  # Parses arguments to separate attributes and content
  def parse_args(args)
    attributes = {}
    content = ""

    args.each do |arg|
      if arg.is_a?(Hash)
        attributes.merge!(arg)
      else
        content = arg.to_s
      end
    end

    [attributes, content]
  end

  # Helper method to add tags to the HTML content
  def add_tag(name, content = "", attributes = {}, &block)
    @html << "<#{name}#{format_attributes(attributes)}>"
    @html << content
    instance_eval(&block) if block_given?
    @html << "</#{name}>"
  end

  # Formats HTML tag attributes into a string
  def format_attributes(attributes)
    attributes.map { |key, value| " #{key}='#{value}'" }.join
  end

  # Checks if a tag is self-closing
  def self_closing_tag?(tag_name)
    %i[area base br col embed hr img input link meta param source track wbr].include?(tag_name)
  end
end

# Example usage of HTMLGenerator
html = HTMLGenerator.new do
  html do
    head do
      title "HTML Example"
    end
    body do
      h1 "This is a Level 1 Heading (h1)"
      h2 "This is a Level 2 Heading (h2)"
      h3 "This is a Level 3 Heading (h3)"
      p "This is a paragraph (p) of text. It can contain " do
        code "code, "
        b "bold, and "
        i "italic text."
      end
      ul do
        li "This is an unordered list (ul) item"
        li "Another unordered list item"
      end
      ol do
        li "This is an ordered list (ol) item"
        li "Another ordered list item"
      end
      p "This is a paragraph with a " do
        pre "preformatted text block."
      end
      img src: "image.jpg", alt: "Sample Image"
      input type: "text", name: "username"
    end
  end
end

# Output the generated HTML and save it to a file
puts html.to_s
html.save_to_file("output.html")