class Project < ApplicationRecord
  belongs_to :user
  acts_as_tenant :account
end
