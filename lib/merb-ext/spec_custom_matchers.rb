module MerbExt
  module SpecCustomMatchers
    def have_message(message, type = :notice)
      ::Webrat::Matchers::HaveXpath.new("//*[contains(@class, '#{type}')][@id='message'][. = '#{message}']")
    end
  
    def have_header(header)
      ::Webrat::Matchers::HaveXpath.new("//h2[. = '#{header}']")
    end
  
    def have_table_cell(content)
      ::Webrat::Matchers::HaveXpath.new("//table/tr/td[contains(. ,'#{content}')]")
    end
  
    def have_table_header(content)
      ::Webrat::Matchers::HaveXpath.new("//table/tr/th[contains(. ,'#{content}')]")
    end
  
    class HaveTable
      def initialize(table)
        @raw = table
        rows = table.split("\n").map {|row| row.split("|").map {|cell| cell.strip} }
        @headers = rows.first
        @rows = rows[1..-1]
      end

      def matches?(target)
        @target = target
        @fields = []
      
        @headers.each_with_index do |header, index|
          matcher = ::Webrat::Matchers::HaveXpath.new("//table/tr[1]/th[#{index+1}][contains(. ,'#{header}')]")
          @fields << header unless matcher.matches?(target)
        end
      
        @rows.each_with_index do |row, row_index|
          row.each_with_index do |cell, cell_index|
            matcher = ::Webrat::Matchers::HaveXpath.new("//table/tr[#{row_index+2}]/td[#{cell_index+1}][contains(. ,'#{cell}')]")
            @fields << cell unless matcher.matches?(target)
          end
        end
      
        @fields.empty?
      end
    
      def failure_message
        "expected #{@target.body} to looks like:\n#{@raw} \n #{@fields.inspect}"
      end
    end
  
    def have_table(table)
      HaveTable.new(table)
    end
  
  end
end