# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pundit::Helper do
  let(:user) { double }
  let(:controller) { Controller.new(user, "update", double) }
  let(:view) { Controller::View.new(controller) }

  describe "#policy_scope" do
    it "doesn't flip pundit_policy_scoped?" do
      scoped = view.policy_scope(Post)

      expect(scoped).to be(Post.published)
      expect(controller).not_to be_pundit_policy_scoped
    end

    it "forwards the provided method to pundit_policy_scope" do
      expect(view).to receive(:pundit_policy_scope).with(Post, :unpublished).and_return(:unpublished)

      expect(view.policy_scope(Post, :unpublished)).to eq :unpublished
    end
  end
end
