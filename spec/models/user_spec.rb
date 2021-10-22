require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = create(:user)
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  it 'has a unique email' do
    user_2 = build(:user, email: @user.email)
    expect(user_2).to_not be_valid
  end

  it 'has an avatar attached' do |arg|
    expect(@user.avatar.attached?).to be true
  end

  # Association Test
  it { should have_many(:comments) }
  it { should have_many(:projects) }
  it { should have_many(:likes) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  it 'returns the full_name for a user' do
    expect(@user.full_name).to eq "#{@user.first_name} #{@user.last_name}"
  end
end
