# frozen_string_literal: true

# User model represents registered users of the application.
class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable

  validates :password, presence: true, length: { minimum: 6 }
  validate :password_confirmation_matches

  has_many :leads

  def assign_role(role)
    add_role role if role.present?
  end

  private

  def password_confirmation_matches
    return unless password.present? && password != password_confirmation

    errors.add(:password_confirmation, 'and password should be the same')
  end
end
