# frozen_string_literal: true

require 'thor'
require 'slack-ruby-client'
require 'tty-spinner'
require 'tty-table'

module SlackChannelStats
  class CLI < Thor
    class Generator
      def initialize(channel_name:, user_name:, latest: nil, oldest: nil)
        @channel_name = channel_name
        @user_name = user_name
        @latest = latest || Time.now.to_i
        @oldest = oldest || (@latest - (60 * 60 * 24 * 365))
        @client = Slack::Web::Client.new
        @container = Container.new(@user_name)
      end

      def fetch
        @client.conversations_history(channel: @channel_name, latest: @latest, oldest: @oldest) do |response|
          @container.add_messages(response.messages)
        end
      end

      def print
        @container.print
      end
    end

    class Container
      def initialize(user_name)
        @user_name = user_name
        @summary = {}
      end

      def add_messages(messages)
        messages.select { |message| message.user == @user_name }.each do |message|
          date = Time.at(message.ts.to_f.to_i).strftime('%F')
          hour = Time.at(message.ts.to_f.to_i / 60 / 60 * 60 * 60)
          @summary[date] ||= {}
          @summary[date][hour] = (@summary[date][hour] || 0) + 1
        end
      end

      def print
        rows = @summary.map do |date, hash|
          [date] + (0...24).to_a.map { |hour| hash.find { |key, _| key.hour == hour }&.last || '_' }
        end
        table = TTY::Table.new([''] + (0...24).to_a, rows.reverse)
        pastel = Pastel.new
        results = table.render(:ascii, alignment: [:center], padding: [0, 1]) do |renderer|
          renderer.filter = lambda { |val, row_index, col_index|
            next val if row_index.zero? || col_index.zero?

            val.to_i.zero? ? pastel.bright_black(val) : pastel.green(val)
          }
        end
        puts results
      end
    end

    desc 'generate', 'generate slack channel stats'
    def generate
      Slack.configure do |config|
        config.token = ENV.fetch('SLACK_TOKEN', nil)
      end

      user_name = 'ULTBHGQ3W'
      channel_name = '#misc_time_ueki'
      generator = Generator.new(channel_name:, user_name:)

      TTY::Spinner.new('[:spinner] Downloading messages...', format: :pulse_2).run do
        generator.fetch
      end

      generator.print
    end

    desc 'version', 'slack_channel_stats version'
    def version
      require_relative 'version'
      puts "v#{SlackChannelStats::VERSION}"
    end
    map %w[--version -v] => :version
  end
end
