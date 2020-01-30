#!/usr/bin/env ruby

require 'spreadsheet'    
require 'fileutils'

Spreadsheet.client_encoding = 'UTF-8'
book = Spreadsheet.open('/Users/Eddie/Downloads/store-final-image_20200129.xls')
basePath = '/Users/Eddie/Downloads/stores'
baseOriginalImagePath = '/Users/Eddie/ebates/kr/content'
sheet1 = book.worksheet 0

sheet1.each do |row|
	storeId = row[0]
	storeName = row[1]
	imageLocation = row[2]
	imageType = row[3]

	if !storeName.nil? and (imageType == 'smallLogo' or imageType == 'largeLogo' or imageType == 'icon-336x90')
	  	dirname = basePath + '/' + storeName
	  	unless imageLocation.start_with?('/')
	  		imageLocation = '/' + imageLocation
	  	end
	  	
	  	orignalImagePath = baseOriginalImagePath + imageLocation

	  	if(File.exist?(orignalImagePath)) 
			FileUtils.mkdir_p dirname
	  		dest_fileName = dirname + '/' + imageType + File.extname(orignalImagePath)
	  		puts dest_fileName
	  		FileUtils.cp(orignalImagePath, dest_fileName)
		  	# puts orignalImagePath + ' file or directory exists ' + imageType + 'completed!'
		else 
		  puts '' + storeId.to_s + orignalImagePath +' file or directory not found ' + imageType
		end
	end
end