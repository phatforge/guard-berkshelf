# encoding: utf-8
require 'spec_helper'

describe Guard::Berkshelf do
  subject { described_class.new }


  context '#berkshelf_install' do

    it 'should call `berks install\' command' do
      subject.should_receive(:system).with('berks install')
      subject.send(:berkshelf_install)
    end

  end

  context '#refresh_berkshelf' do

    it 'should call #berkshelf_install' do
      subject.should_receive(:berkshelf_install).and_return(:berkshelf_installed)
      subject.send(:refresh_berkshelf).should be_true
    end

    it 'should return false if #berkshelf_install fails' do
      subject.should_receive(:berkshelf_install).and_return(false)
      subject.send(:refresh_berkshelf).should be_false
    end

    it 'should call notifier after #berkshelf_install succeeds' do
      subject.should_receive(:berkshelf_install).and_return(:berkshelf_installed)
      Guard::Berkshelf::Notifier.should_receive(:notify).with(true, anything())
      subject.send(:refresh_berkshelf)
    end

    it 'should call notifier after #berkshelf_install fails' do
      subject.should_receive(:berkshelf_install).and_return(false)
      Guard::Berkshelf::Notifier.should_receive(:notify).with(false, anything())
      subject.send(:refresh_berkshelf)
    end


  end

  context '#start' do

    it 'should call #refresh_berkshelf' do
      subject.should_receive(:refresh_berkshelf).and_return(true)
      subject.start
    end

  end

  context '#reload' do

    it 'should call #refresh_berkshelf' do
      subject.should_receive(:refresh_berkshelf).and_return(true)
      subject.reload
    end

  end

  context '#run_all' do

    it 'should call #refresh_berkshelf' do
      subject.should_receive(:refresh_berkshelf).and_return(true)
      subject.run_all
    end

  end

  context '#run_on_additions' do

    it 'should call #refresh_berkshelf' do
      subject.should_receive(:refresh_berkshelf).and_return(true)
      subject.run_on_additions
    end

  end

  context '#run_on_modifications' do

    it 'should call #refresh_berkshelf' do
      subject.should_receive(:refresh_berkshelf).and_return(true)
      subject.run_on_modifications
    end

  end

end
