module Ruboty
  module CircleCIV2
    module Actions
      class RunPipeline < Base
        def call
          if has_personal_api_token?
            run_pipeline
          else
            require_personal_api_token
          end
        end

        private

        def run_pipeline
          connection.post do |request|
            request.body = {
              branch: branch,
              parameters: parameters
            }.to_json
          end
        end

        def branch
          message[:branch]
        end

        def parameters
          JSON.parse(message[:params])
        end
      end
    end
  end
end