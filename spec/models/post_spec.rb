require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Post Model' do
    subject { Post.create(title: 'Title test', text: 'text', user_id: 1) }
    before { subject.save }

    it 'checks if subject is invalid if there is no title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'tests if title more than 250chs to be invalid' do
      subject.title = 'more than 250 more than 250 more than 250 more
      than 250 more than 250 more than 250 more than 250 more than 250 more than 250 more than 250 more than 250 more
      than 250 more than 250 more than 250 more than 250 more than 250 more than 250 more than 250 '
      expect(subject).to_not be_valid
    end
  end
  describe 'Post Model methods' do
    before do
      6.times do |number|
        subject.id = 1
        Comment.create(text: "test comment #{number}", user_id: 1, post: subject)
      end
    end
  end
end
