# fronzen_string_literal: true

require 'sql_analyzer/version'
require 'sql_analyzer/transaction_manager'
require 'sql_analyzer/abstract_connection_adapter'

module SqlAnalyzer
  # Enable monkey patching: you should call this method on application initialize phase.
  class << self
    def init!
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::ConnectionAdapters::TransactionManager.prepend SqlAnalyzer::TransactionManagerPatch
        ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend SqlAnalyzer::AbstractConnectionAdapterPatch
      end
    end
  end
end
