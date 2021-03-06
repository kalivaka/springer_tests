require 'minitest/autorun'
require 'rest_client'

class APITestSearchScenario < Minitest::Test
  def test_search_responds
    @response = make_search_request
    assert_equal 200, @response.code
  end

  def test_unhappy_path
    @response = make_search_request "somethingunexisting23ru389h32hrh" 
    assert @response.body.match("we couldn’t find what you are looking for")
  end

  def test_happy_path
    @response = make_search_request
    assert @response.body.match("Result(s)")
  end

  # This test case is failing, because pagination doesnt convert -3 to 1 for example
  def test_pagination
    @response = RestClient.get("http://rd.springer.com/search/page/-3?query=programming") 
    assert !@response.body.match("Page -3")
  end

  def make_search_request(query = "programming")
  	RestClient.get("http://rd.springer.com/search/?query=#{query}") 
  end
end
