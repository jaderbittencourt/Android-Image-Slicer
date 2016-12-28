# encoding: UTF-8
require 'rubygems'
require 'RMagick'
require 'json'
require 'rest-client'
include Magick

class Converter

  PATH = ARGV[0]
  ACCEPTED_FORMATS = [".jpg", ".png"]

  def start path
    files = Dir.entries(path)
    files.delete('.')
    files.delete('..')
    prepareImages path
  end

  def prepareImages path
    files = Dir.entries(path)
    files.delete('.')
    files.delete('..')

    if !Dir["#{path}/*.jpg"].empty? || !Dir["#{path}/*.png"].empty?
      puts "Creating android drawable folders"
      createFolders path
    end

    # @files = []

    puts "","-- TOTAL FILES: : #{files.size }",""
    files = files.sort
    GC.start
    files.each do |f|
      if ACCEPTED_FORMATS.include? File.extname(f)
        puts "","-- valid file: #{f}"
        generateImages path, f
      else
        puts "","-- INVALID FILE: #{f}"
      end
    end
  end

  def createFolders path
    folders = ['drawable-xxhdpi',  'drawable-xhdpi',  'drawable-hdpi']
    # folders = ['drawable-xxxhdpi', 'drawable-xxhdpi',  'drawable-xhdpi',  'drawable-hdpi',  'drawable-mdpi',  'drawable-ldpi']
    folders.each do |folder|
      unless Dir.exists? "#{path}/#{folder}"
        FileUtils.mkdir_p "#{path}/#{folder}/"
      end
    end
  end

  def generateImages path, file
    dimensions = {'drawable-xxhdpi' => 1.0,  'drawable-xhdpi' => 0.75,  'drawable-hdpi' => 0.5 }
    dimensions.each do |dimension, v|
      scale path, file, dimension, v
    end
  end

  def scale path, filename, prefix, float
    # puts "---- resizing file: #{filename} - #{prefix} "
    cat = ImageList.new("#{path}/#{filename}")
    res = cat.scale(float)
    # puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    # puts "#{path}#{prefix}/#{filename}"
    # puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"

    res.write  "#{path}#{prefix}/#{filename}"
    GC.start
  end
end

converter = Converter.new
converter.start ARGV[0]
