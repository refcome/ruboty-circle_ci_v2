module Ruboty
  module Handlers
    class CircleCIV2 < Base
      on(
        /remember my circleci personal api token (?<token>.+)\z/,
        name: "remember",
        description: "Remember sender's CircleCI personal api token",
      )

      on(
        /run circleci pipeline of branch (?<branch>.+) on (?<project_slug>.+) with params (?<params>.+)\z/,
        name: "run_pipeline",
        description: "Run pipeline with params",
      )

      def remember(message)
        Ruboty::CircleCIV2::Actions::Remember.new(message).call
      end

      def run_pipeline(message)
        Ruboty::CircleCIV2::Actions::RunPipeline.new(message).call
      end
    end
  end
end
