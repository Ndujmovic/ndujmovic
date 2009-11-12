class EngineersControllerTest < ActionController::TestCase
def test_create
# Simulate a POST response with the given HTTP parameters.
post(:create, :engineer => { :fname => "Nancy",
        :lname => "Dujmovic", :years_of_experience = 3 })

assert_response :found

assert_not_nil Engineer.find_by_fname("Nancy")
end
end

