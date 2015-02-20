class PandaController < ApplicationController
  # Skipping the check here because none of these actions modify
  # our db.  Check is done on glyphs/comments controllers
  # before the db is modified.  May need to revisit this as
  # folks could still push videos to our S3 server with the
  # right config info for Pandastream.
  skip_before_filter :verify_authenticity_token

  def upload_payload
    @upload_payload ||= JSON.parse(params['payload'])
  end

  def authorize_upload
    upload = Panda.post('/videos/upload.json', {
      file_name: upload_payload['filename'],
      file_size: upload_payload['filesize'],
      profiles: "h264",
    })

    render :json => {:upload_url => upload['location']}
  end
end          
