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
    // let score = document.getElementById('review_score_' + event.target.getAttribute("review_id"));
    // let scoreValue = score.innerText;
    // let scoreMinusOne = scoreValue - 1;
    // let scorePlusOne =  scoreValue + 1;
    // let scorePlusTwo =  scoreValue + 2;

    event.preventDefault();
    event.stopImmediatePropagation();

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
              $("#upvote_" + event.target.getAttribute("review_id")).addClass("upvote");
              // scoreValue = scorePlusOne;
            }
          });

        } else if (votes.find(checkVoteExists).choice == 1) {
          $("#upvote_" + event.target.getAttribute("review_id")).removeClass("upvote");
          $.ajax({
            method: 'PUT',
            url: '/api/v1/review_votes/' + votes.find(checkVoteExists).id,
            data: { choice: 0 },
            success: function(changeVote) {
              // score.innerText = scoreMinusOne;
            },
            error: function() {
              alert("Vote was not changed");
            }
          });

        } else if (votes.find(checkVoteExists).choice === 0) {
          $("#downvote_" + event.target.getAttribute("review_id")).removeClass("downvote");
          $("#upvote_" + event.target.getAttribute("review_id")).addClass("upvote");
          $.ajax({
            method: 'PUT',
            url: '/api/v1/review_votes/' + votes.find(checkVoteExists).id,
            data: { choice: 1 },
            success: function(changeVote) {
              // scoreValue = scorePlusOne;
            },
            error: function() {
              alert("Vote was not changed");
            }
          });
        } else if (votes.find(checkVoteExists).choice == -1) {
          $("#downvote_" + event.target.getAttribute("review_id")).removeClass("downvote");
          $("#upvote_" + event.target.getAttribute("review_id")).addClass("upvote");
          $.ajax({
            method: 'PUT',
            url: '/api/v1/review_votes/' + votes.find(checkVoteExists).id,
            data: { choice: 1 },
            success: function(changeVote) {
              // score.innerText = scorePlusTwo;
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
    event.stopImmediatePropagation();

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
              $("#downvote_" + event.target.getAttribute("review_id")).addClass("downvote");
              // score.innerText = ScoreMinusOne;
            }
          });

        } else if (votes.find(checkVoteExists).choice == -1) {
          $("#downvote_" + event.target.getAttribute("review_id")).removeClass("downvote");
          $.ajax({
            method: 'PUT',
            url: '/api/v1/review_votes/' + votes.find(checkVoteExists).id,
            data: { choice: 0 },
            success: function(changeVote) {
              // score.innerText = scorePlusOne;
            },
            error: function() {
              alert("Vote was not changed");
            }
          });

        } else if (votes.find(checkVoteExists).choice === 0) {
          $("#upvote_" + event.target.getAttribute("review_id")).removeClass("upvote");
          $("#downvote_" + event.target.getAttribute("review_id")).addClass("downvote");
          $.ajax({
            method: 'PUT',
            url: '/api/v1/review_votes/' + votes.find(checkVoteExists).id,
            data: { choice: -1 },
            success: function(changeVote) {
              // score.innerText = scoreMinusOne;
            },
            error: function() {
              alert("Vote was not changed");
            }
          });
        } else if (votes.find(checkVoteExists).choice == 1) {
          $("#upvote_" + event.target.getAttribute("review_id")).removeClass("upvote");
          $("#downvote_" + event.target.getAttribute("review_id")).addClass("downvote");
          $.ajax({
            method: 'PUT',
            url: '/api/v1/review_votes/' + votes.find(checkVoteExists).id,
            data: { choice: -1 },
            success: function(changeVote) {
              // score.innerText = scoreMinusTwo;
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
