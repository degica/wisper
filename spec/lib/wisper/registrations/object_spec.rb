describe Wisper::ObjectRegistration do

  describe 'broadcaster' do
    it 'defaults to SendBroadcaster' do
      subject = Wisper::ObjectRegistration.new(double('listener'), {})
      expect(subject.broadcaster).to be_instance_of(Wisper::Broadcasters::SendBroadcaster)
    end

    it 'default is lazily evaluated' do
      expect(Wisper::Broadcasters::SendBroadcaster).to_not receive :new
      Wisper::ObjectRegistration.new(double('listener'), broadcaster: double('DifferentBroadcaster').as_null_object)
    end
  end

  describe 'broadcast' do
    it 'instantiates class listeners before calling `broadcaster.broadcast`' do
      listener_class = Class.new { def event; end }
      expect_any_instance_of(listener_class).to receive(:event)

      subject = Wisper::ObjectRegistration.new(listener_class, {})
      subject.broadcast(:event, double('Publisher'))
    end
  end
end
