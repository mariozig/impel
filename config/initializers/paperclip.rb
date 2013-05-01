Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_credentials] = {
  :bucket => Figaro.env.s3_bucket,
  :access_key_id => Figaro.env.s3_access_key_id,
  :secret_access_key => Figaro.env.s3_secret_access_key
}