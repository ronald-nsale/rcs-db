# encoding: utf-8
#
#  License handling stuff
#

# from RCS::Common
require 'rcs-common/trace'
require 'rcs-common/crypt'

class LicenseManager
  include Singleton
  include RCS::Tracer

  def check(field)

    case (field)

      when :alerting
        return @limits['alerting']

      when :archive
        return @limits['archive']

      when :ocr
        return @limits['ocr']

      when :translation
        return @limits['translation']

      when :correlation
        return @limits['correlation']

      when :intelligence
        return @limits['intelligence']

      when :connectors
        return @limits['connectors']
    end

    return false
  end

  def load_from_db
    db = RCS::DB::DB.instance.session
    @limits = db['license'].find({}).first
    raise "Cannot load license information from db, retrying in 5 seconds..." unless @limits
  rescue Exception => e
    trace :error, e.message
    sleep 5
    retry
  end

end

