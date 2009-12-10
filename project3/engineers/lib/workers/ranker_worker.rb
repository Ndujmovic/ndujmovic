class RankerWorker < BackgrounDRb::MetaWorker
  set_worker_name :ranker_worker
  def create(args = nil)
    # this method is called, when worker is loaded for the first time
  end
  def dothis
     puts "Hi!"
  end
end

