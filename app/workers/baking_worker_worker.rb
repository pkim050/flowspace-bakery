class BakingWorkerWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    @cookie_id = args[0]
    @cookie = Cookie.find @cookie_id
    @cookie.update_attributes(status: "ready")
  end
end
