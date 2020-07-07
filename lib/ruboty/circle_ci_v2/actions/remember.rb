module Ruboty
  module CircleCIV2
    module Actions
      class Remember < Base
        def call
          remember
          report
        end

        private

        def report
          message.reply("Remembered #{sender_name}'s CircleCI personal api token")
        end

        def remember
          personal_api_tokens[sender_name] = given_personal_api_token
        end

        def given_personal_api_token
          message[:token]
        end
      end
    end
  end
end
