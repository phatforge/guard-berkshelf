# encoding: utf-8
require 'spec_helper'

describe Guard::Berkshelf::Notifier do
  subject { Guard::Berkshelf::Notifier }

  it 'should format success message' do
    message = subject.guard_message(true, 10.1)
    message.should == "Berkshelf has been installed\nin 10.1 seconds."
  end

  it 'should format fail message' do
    message = subject.guard_message(false, 10.1)
    message.should == "Berkshelf can't be installed,\nplease check manually."
  end

  it 'should select success image' do
    subject.guard_image(true).should == :success
  end

  it 'should select failed image' do
    subject.guard_image(false).should == :failed
  end

  it 'should call Guard::Notifier' do
    ::Guard::Notifier.should_receive(:notify).with(
      "Berkshelf has been installed\nin 10.1 seconds.",
      title: 'berks install',
      image: :success
    )
    subject.notify(true, 10.1)
  end

end
