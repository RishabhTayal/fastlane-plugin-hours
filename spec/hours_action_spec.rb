describe Fastlane::Actions::HoursAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The hours plugin is working!")

      Fastlane::Actions::HoursAction.run(nil)
    end
  end
end
