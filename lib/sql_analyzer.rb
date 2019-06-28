# fronzen_string_literal: true

require 'sql_analyzer/version'
require 'sql_analyzer/transaction/transaction_manager'
require 'sql_analyzer/transaction/abstract_connection_adapter'
require 'sql_analyzer/join/abstract_connection_adapter'

module SqlAnalyzer
  # Enable monkey patching: you should call this method on application initialize phase.
  class << self
    def init!(mode:)
      raise 'mode should be :transaction OR :join' unless mode.in? %i[transaction join]

      ActiveSupport.on_load(:active_record) do
        if mode == :transaction
          ActiveRecord::ConnectionAdapters::TransactionManager.prepend SqlAnalyzer::Transaction::TransactionManagerPatch
          ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend SqlAnalyzer::Transaction::AbstractConnectionAdapterPatch
        else
          ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend SqlAnalyzer::Join::AbstractConnectionAdapterPatch
        end
      end
    end
  end
end
