class ProjectsControllerTest < ActionController::TestCase
def test_create
# Simulate a POST response with the given HTTP parameters.
post(:create, :project => { :name => "Test",
        :description => 3 })

assert_response :found

assert_not_nil Project.find_by_fname("Test")
end
end

