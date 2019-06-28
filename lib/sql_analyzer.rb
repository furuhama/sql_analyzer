# fronzen_string_literal: true

require 'sql_analyzer/version'
require 'sql_analyzer/transaction/transaction_manager'
require 'sql_analyzer/transaction/abstract_connection_adapter'

module SqlAnalyzer
  # Enable monkey patching: you should call this method on application initialize phase.
  class << self
    def init!
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::ConnectionAdapters::TransactionManager.prepend SqlAnalyzer::Transaction::TransactionManagerPatch
        ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend SqlAnalyzer::Transaction::AbstractConnectionAdapterPatch
      end
    end
  end
end
