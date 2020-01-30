#!/usr/bin/env ruby

require 'spreadsheet'    
require 'fileutils'

def prompt(*args)
    print(*args)
    gets.strip
end

Spreadsheet.client_encoding = 'UTF-8'
excelPath = prompt 'Input Excel File Path: '
unless File.exist?(excelPath)
	puts "Unable to locate file \nPlease check if location of the file is correct"
	return
end

basePath = prompt 'Input Parent folder for image: (Optional) '
basePath = basePath.empty? ? 'tmp' : basePath

baseOriginalImagePath = prompt 'Base Parent path: (Optional) '
baseOriginalImagePath = baseOriginalImagePath.empty? ? '' : baseOriginalImagePath

# return
book = Spreadsheet.open(excelPath)
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


