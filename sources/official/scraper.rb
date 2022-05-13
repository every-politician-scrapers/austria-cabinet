#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.text.tidy
    end

    def position
      noko.xpath('following::p').first.xpath('.//text()').map(&:text).map { |txt| txt.delete_suffix(',') }.map(&:tidy)
    end
  end

  class Members
    def members
      super.reject { |mem| mem[:name] == 'Notes' }
    end

    def member_container
      noko.css('#content h2')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
