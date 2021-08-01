require "test_helper"

class OverrideApplicationLayoutTest < ActionDispatch::IntegrationTest
  controller(ApplicationController) do
    def index
    end
  end

  views["index.html.erb"] = <<~HTML
    <h2>Anonymous home page</h2>
  HTML

  views["layouts/application.html.erb"] = <<~HTML
    <h1>Overridden application layout</h1>
    <%= yield %>
  HTML

  test "GET anonymous index loads" do
    get "/anonymous"
    assert_response 200
    assert_select "h1", "Overridden application layout"
    assert_select "h2", "Anonymous home page"
  end
end
