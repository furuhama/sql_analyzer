# fronzen_string_literal: true

module SqlAnalyzer
  module TransactionManagerPatch
    attr_accessor :caller_stack, :tables, :database

    def initialize(connection)
      super

      @caller_stack = []
      @tables = []
    end

    def begin_transaction(options = {})
      caller_location = caller_locations.find { |cl| cl.to_s.start_with?('/').! }
      caller_stack.push(caller_location)

      super
    end

    def commit_transaction
      log = if tables.empty?
              {
                trx_location: caller_stack.join(','),
                message: 'WARNING: transaction is defined but no records are changed under its effct. You should remove it.'
              }
            else
              {
                trx_location: caller_stack.join(','),
                database: database,
                tables: tables.uniq,
              }
            end

      # TODO: Replace this with logger
      p log
    ensure
      self.tables = []
      self.caller_stack = []
      self.database = nil

      super
    end
  end
end
