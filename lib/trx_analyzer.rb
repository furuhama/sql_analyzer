# fronzen_string_literal: true

require 'trx_analyzer/version'
require 'trx_analyzer/transaction_manager'
require 'trx_analyzer/abstract_connection_adapter'

module TrxAnalyzer
  # TODO: Initialize method
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::ConnectionAdapters::TransactionManager.prepend TrxAnalyzer::TransactionManagerPatch
  ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend TrxAnalyzer::AbstractConnectionAdapterPatch
end
