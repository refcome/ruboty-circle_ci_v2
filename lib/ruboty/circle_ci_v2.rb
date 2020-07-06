require "faraday"
require "json"
require "ruboty"
require "ruboty/circle_ci_v2/actions/base"
require "ruboty/circle_ci_v2/actions/remember"
require "ruboty/circle_ci_v2/actions/run_pipeline"
require "ruboty/circle_ci_v2/version"
require "ruboty/handlers/circle_ci_v2"

module Ruboty
  module CircleCIV2
    class Error < StandardError; end
    # Your code goes here...
  end
end
