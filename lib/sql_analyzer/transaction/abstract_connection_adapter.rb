# fronzen_string_literal: true

module SqlAnalyzer
  module Transaction
    module AbstractConnectionAdapterPatch
      def to_sql_and_binds(arel_or_sql_string, binds = [])
        case arel_or_sql_string
        when String
          # TODO: If write query come with String class value,
          #     : implementation of SQL parser code is needed.
          # Do nothing for now
        when Arel::InsertManager, Arel::UpdateManager, Arel::DeleteManager
          database = @connection.query_options[:database]
          table_name = arel_or_sql_string.ast.relation.name.gsub("#{database}.", '')

          transaction_manager.database = database
          transaction_manager.tables.push(table_name)
        else
          # Do nothing
        end

        super
      end
    end
  end
end
