# fronzen_string_literal: true

module SqlAnalyzer
  module Join
    module AbstractConnectionAdapterPatch
      def to_sql_and_binds(arel_or_sql_string, binds = [])
        case arel_or_sql_string
        when Arel::SelectManager
          # Get caller_locations here (before call #analyze_join_sources for stack search)
          caller_location = caller_locations.find { |cl| cl.to_s.start_with?('/').! }

          analyze_join_sources(arel_or_sql_string, caller_location)
        else
          # Do nothing
        end

        super
      end

      private

      def analyze_join_sources(arel, caller_location)
        return if arel.join_sources.blank?

        tables = []

        tables << arel.source.left.name

        arel.join_sources.each do |src|
          tables << src.left.name
        end

        log = {
          source_location: caller_location,
          tables: tables.uniq,
          sql: arel.to_sql,
          joins: arel.join_sources.map(&:to_sql)
        }

        pp log
      end
    end
  end
end
