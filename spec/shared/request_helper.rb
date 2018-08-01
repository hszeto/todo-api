module RequestHelper
  def last_response
    OpenStruct.new({
      body: JSON.parse(response.body),
      status: response.status
    })
  end
end