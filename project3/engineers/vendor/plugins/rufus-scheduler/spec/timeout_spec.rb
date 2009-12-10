
#
# Specifying rufus-scheduler
#
# Sun May  3 15:44:28 JST 2009
#

require File.dirname(__FILE__) + '/spec_base'


describe "#{SCHEDULER_CLASS} timeouts" do

  before do
    @s = start_scheduler
  end
  after do
    stop_scheduler(@s)
  end

  it 'should should refuse to schedule a job with :timeout and :blocking' do

    lambda {
      @s.in '1s', :timeout => '3s', :blocking => true do
      end
    }.should.raise(ArgumentError)
  end

  it 'should schedule a dedicated job for the timeout' do

    @s.in '1s', :timeout => '3s' do
      sleep 5
    end

    @s.jobs.size.should.equal(1)

    # the timeout job is left

    sleep 2
    @s.jobs.size.should.equal(1)
    @s.find_by_tag('timeout').size.should.equal(1)
  end

  it 'should time out' do

    var = nil
    timedout = false

    @s.in '1s', :timeout => '1s' do
      begin
        sleep 2
        var = true
      rescue Rufus::Scheduler::TimeOutError => e
        timedout = true
      end
    end

    sleep 4

    var.should.be.nil
    @s.jobs.size.should.equal(0)
    timedout.should.be.true
  end

  it 'should die silently if job finished before timeout' do

    var = nil
    timedout = false

    @s.in '1s', :timeout => '1s' do
      begin
        var = true
      rescue Rufus::Scheduler::TimeOutError => e
        timedout = true
      end
    end

    sleep 3

    var.should.be.true
    @s.jobs.size.should.equal(0)
    timedout.should.be.false
  end
end

