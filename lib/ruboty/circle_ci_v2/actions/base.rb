module Ruboty
  module CircleCIV2
    module Actions
      class Base
        NAMESPACE = "circle_ci_v2"

        attr_reader :message

        def initialize(message)
          @message = message
        end

        private

        def personal_api_tokens
          message.robot.brain.data[NAMESPACE] ||= {}
        end

        def body
          message[:description] || ""
        end

        def sender_name
          message.from_name
        end

        def require_personal_api_token
          message.reply("I don't know your CircleCI Personal API Token")
        end

        def has_personal_api_token?
          !!personal_api_token
        end

        def personal_api_token
          @personal_api_token ||= personal_api_tokens[sender_name]
        end

        def connection
          Faraday.new(url: api_endpoint) do |builder|
            builder.request :url_encoded
            builder.adapter :net_http
            builder.basic_auth personal_api_token, ""
            builder.headers["Content-Type"] = "application/json"
          end
        end

        def repository
          message[:repo]
        end

        def api_endpoint
          "#{circle_ci_v2_base_url}/#{repository}/pipeline"
        end

        def circle_ci_v2_base_url
          "https://circleci.com/api/v2/project"
        end
      end
    end
  end
end
