$(function (){
  // this block modifies the vote buttons to indicate how the
  // current_user has voted
  $.ajax({
    method: 'GET',
    url: '/api/v1/review_votes',
    success: function(votes) {
      $.each(votes, function(x, vote){
        if (vote.user_id == window.user_id && vote.park_id == window.park_id) {
          if (vote.choice == 1) {
            $("#upvote_" + vote.review_id).addClass("upvote");
          } else if (vote.choice == -1) {
            $("#downvote_" + vote.review_id).addClass("downvote");
          }
        }
      });
    }
  });

  $('.upvote-arrow').on('click', function(event) {
    event.preventDefault();

    $.ajax({
      method: 'GET',
      url: '/api/v1/review_votes',
      success: function(votes) {
        function checkVoteExists(vote) {
          return vote.user_id == window.user_id && vote.review_id == event.target.getAttribute("review_id");
        }
        // if vote doesn't exist, new vote created
        if (votes.find(checkVoteExists) === undefined) {
          let newUpvote = {
            choice: 1,
            park_id: window.park_id,
            review_id: event.target.getAttribute("review_id"),
            user_id: window.user_id,
            created_at: Date(),
            updated_at: Date(),
          };

          $.ajax({
            method: 'POST',
            url: '/api/v1/review_votes',
            data: newUpvote,
            success: function(newVote) {
              let current_score_id = ("#review_score_" + event.target.getAttribute("review_id"));
              $(current_score_id).load(`/parks/${window.park_id} ${current_score_id}`, function() { });
              $("#upvote_" + event.target.getAttribute("review_id")).addClass("upvote");
            }
          });

        } else if (votes.find(checkVoteExists).choice == 1) {
          $("#upvote_" + event.target.getAttribute("review_id")).removeClass("upvote");
          let current_score_id = ("#review_score_" + event.target.getAttribute("review_id"));
          $.ajax({
            method: 'PUT',
            url: '/api/v1/review_votes/' + votes.find(checkVoteExists).id,
            data: { choice: 0 },
            success: function(changeVote) {
              $(current_score_id).load(`/parks/${window.park_id} ${current_score_id}`, function() { });
            },
            error: function() {
              alert("Vote was not changed");
            }
          });

        } else if (votes.find(checkVoteExists).choice === 0) {
          $("#downvote_" + event.target.getAttribute("review_id")).removeClass("downvote");
          $("#upvote_" + event.target.getAttribute("review_id")).addClass("upvote");
          let current_score_id = ("#review_score_" + event.target.getAttribute("review_id"));
          $.ajax({
            method: 'PUT',
            url: '/api/v1/review_votes/' + votes.find(checkVoteExists).id,
            data: { choice: 1 },
            success: function(changeVote) {
              $(current_score_id).load(`/parks/${window.park_id} ${current_score_id}`, function() { });
            },
            error: function() {
              alert("Vote was not changed");
            }
          });
        } else if (votes.find(checkVoteExists).choice == -1) {
          $("#downvote_" + event.target.getAttribute("review_id")).removeClass("downvote");
          $("#upvote_" + event.target.getAttribute("review_id")).addClass("upvote");
          let current_score_id = ("#review_score_" + event.target.getAttribute("review_id"));
          $.ajax({
            method: 'PUT',
            url: '/api/v1/review_votes/' + votes.find(checkVoteExists).id,
            data: { choice: 1 },
            success: function(changeVote) {
              $(current_score_id).load(`/parks/${window.park_id} ${current_score_id}`, function() { });
            },
            error: function() {
              alert("Vote was not changed");
            }
          });
        }
      }
    });
  });

  $('.downvote-arrow').on('click', function(event) {
    event.preventDefault();

    $.ajax({
      method: 'GET',
      url: '/api/v1/review_votes',
      success: function(votes) {
        function checkVoteExists(vote) {
          return vote.user_id == window.user_id && vote.review_id == event.target.getAttribute("review_id");
        }
        // if vote doesn't exist, new vote created
        if (votes.find(checkVoteExists) === undefined) {
          let newUpvote = {
            choice: -1,
            park_id: window.park_id,
            review_id: event.target.getAttribute("review_id"),
            user_id: window.user_id,
            created_at: Date(),
            updated_at: Date(),
          };
          $.ajax({
            method: 'POST',
            url: '/api/v1/review_votes',
            data: newUpvote,
            success: function(newVote) {
              let current_score_id = ("#review_score_" + event.target.getAttribute("review_id"));
              $(current_score_id).load(`/parks/${window.park_id} ${current_score_id}`, function() { });
              $("#downvote_" + event.target.getAttribute("review_id")).addClass("downvote");
            }
          });

        } else if (votes.find(checkVoteExists).choice == -1) {
          let current_score_id = ("#review_score_" + event.target.getAttribute("review_id"));
          $("#downvote_" + event.target.getAttribute("review_id")).removeClass("downvote");
          $.ajax({
            method: 'PUT',
            url: '/api/v1/review_votes/' + votes.find(checkVoteExists).id,
            data: { choice: 0 },
            success: function(changeVote) {
              $(current_score_id).load(`/parks/${window.park_id} ${current_score_id}`, function() { });
            },
            error: function() {
              alert("Vote was not changed");
            }
          });

        } else if (votes.find(checkVoteExists).choice === 0) {
          let current_score_id = ("#review_score_" + event.target.getAttribute("review_id"));
          $("#upvote_" + event.target.getAttribute("review_id")).removeClass("upvote");
          $("#downvote_" + event.target.getAttribute("review_id")).addClass("downvote");
          $.ajax({
            method: 'PUT',
            url: '/api/v1/review_votes/' + votes.find(checkVoteExists).id,
            data: { choice: -1 },
            success: function(changeVote) {
              $(current_score_id).load(`/parks/${window.park_id} ${current_score_id}`, function() { });
            },
            error: function() {
              alert("Vote was not changed");
            }
          });
        } else if (votes.find(checkVoteExists).choice == 1) {
          let current_score_id = ("#review_score_" + event.target.getAttribute("review_id"));
          $("#upvote_" + event.target.getAttribute("review_id")).removeClass("upvote");
          $("#downvote_" + event.target.getAttribute("review_id")).addClass("downvote");
          $.ajax({
            method: 'PUT',
            url: '/api/v1/review_votes/' + votes.find(checkVoteExists).id,
            data: { choice: -1 },
            success: function(changeVote) {
              $(current_score_id).load(`/parks/${window.park_id} ${current_score_id}`, function() { });
            },
            error: function() {
              alert("Vote was not changed");
            }
          });
        }

      }
    });
  });

});
