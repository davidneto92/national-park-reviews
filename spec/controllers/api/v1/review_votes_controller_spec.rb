# RSpec.describe Api::V1::ReviewVotesController, type: :controller do
# #
# #   describe "POST /api/v1/review_votes" do
# #     # this test tests the controllers response to the request to create a comment
# #     it "upvotes a review" do
# #       # a Comment object is built but not persisted to the database
# #       comment = build(:comment)
# #
# #       # Rspec allows us to make a request with HTTP verbs (post),
# #       # specify a method in the controller to call (:create)
# #       # as well as specify params to be made available in the method
# #       post :create, params: { comment: comment.attributes }
# #
# #       # a response object is created when the test receives a response
# #       # assert that the response has a specific HTTP status
# #       expect(response).to have_http_status(:created)
# #       # assert that the response has a header with a specific value
# #       expect(response.header["Location"]).to match /\/api\/v1\/comments/
# #     end
# #
# #     it "returns 'not_found' if validations fail" do
# #       post :create, params: { comment: { title: "", content: "", video_id: 0 } }
# #       expect(response).to have_http_status(:not_found)
# #     end
# #   end
# end
