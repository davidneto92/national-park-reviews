class Park < ApplicationRecord
  mount_uploader :main_image, ParkPictureUploader

  belongs_to :user
  has_many :reviews, :dependent => :delete_all
  has_many :park_votes, :dependent => :delete_all
  has_many :review_votes, :dependent => :delete_all

  has_many :park_forecasts

  validates :name, presence: true, uniqueness: { message: " - This park has already been created." }
  validates :main_image, presence: true

  STATES = [
    "Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi",
    "Missouri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "New York",
    "North Carolina",
    "North Dakota",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Vermont",
    "Virginia",
    "Washington",
    "West Virginia",
    "Wisconsin",
    "Wyoming",
    "US Territories",
  ]

  ABBREVIATIONS = [
    "AL",
    "AK",
    "AZ",
    "AR",
    "CA",
    "CO",
    "CT",
    "DE",
    "FL",
    "GA",
    "HI",
    "ID",
    "IL",
    "IN",
    "IA",
    "KS",
    "KY",
    "LA",
    "ME",
    "MD",
    "MA",
    "MI",
    "MN",
    "MS",
    "MO",
    "MN",
    "NB",
    "NV",
    "NH",
    "NJ",
    "NM",
    "NY",
    "NC",
    "ND",
    "OH",
    "OK",
    "OR",
    "PA",
    "RI",
    "SC",
    "SD",
    "TN",
    "TX",
    "UT",
    "VM",
    "VA",
    "WA",
    "WV",
    "WI",
    "WY",
    "USA",
  ]

  def calculate_score
    if !self.park_votes.empty?
      return self.park_votes.inject(0){|sum, vote| sum + vote.choice }
    else
      return 0
    end
  end

  def state_abbreviation
    Park::ABBREVIATIONS[ Park::STATES.index(self.state) ]
  end

end
