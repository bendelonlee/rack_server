
require "./test/test_helper"

class ErrorpageTest < CapybaraTestCase
  def test_user_will_recieve_a_page_not_found_error_if_the_page_does_not_exist
    visit "something_that_doesnt_exist"
    assert page.has_content?("Page not found")
    assert_equal 404, page.status_code
  end

end
