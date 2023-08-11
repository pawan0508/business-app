class Lead < ApplicationRecord
  belongs_to :user
  enum :status, { published: 0, draft: 1, archived: 2 }
end
