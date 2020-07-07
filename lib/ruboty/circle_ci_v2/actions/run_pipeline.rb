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
          pipeline_response = connection.post("project/#{project_slug}/pipeline") do |request|
            request.body = {
              branch: branch,
              parameters: parameters
            }.to_json
          end
          pipeline = JSON.parse(pipeline_response.body)

          workflow_response = connection.get("pipeline/#{pipeline["id"]}/workflow")
          workflow = JSON.parse(workflow_response.body)

          if workflow["items"].empty?
            pipeline_url = "https://app.circleci.com/pipelines/#{project_slug}?#{URI.encode_www_form(branch: branch)}"
            message.reply("Triggered #{pipeline_url}")
            return
          end

          workflow_item_id = workflow["items"].first["id"]
          workflow_url = "https://app.circleci.com/pipelines/#{project_slug}/#{pipeline["number"]}/workflows/#{workflow_item_id}"

          message.reply("Triggered #{workflow_url}")
        rescue => e
          message.reply("An error has occurred: #{e.message}")
        end

        def parameters
          JSON.parse(message[:params])
        end

        def project_slug
          message[:project_slug]
        end

        def branch
          message[:branch]
        end
      end
    end
  end
end