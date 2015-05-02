require 'nokogiri'
require 'pry'
require 'json'
require 'rest-client'


courses = []
(1..1).each do |page_number|

	string = nil

	if File.exist?("1031/#{page_number}.html")
		string = File.read("1031/#{page_number}.html")
	else
		url = "http://timetable.nctu.edu.tw/?r=main/get_cos_list"

		string = (RestClient.post url, { m_acy: '103', m_sem: '1', m_degree: '**', m_dep_id: '**', m_group: '**', m_grade: '**', m_class: '**', m_option: 'crsname', m_crsname: ' ', m_teaname: '**', m_cos_id: '**', m_cos_code: '**', m_crstime: '**', m_crsoutline: '**' }).to_s
	

		File.open("1031/#{page_number}.html", 'w') {|f| f.write(string)}
	end

	courses = JSON.parse(string)

end
File.open('courses.json','w'){|file| file.write(JSON.pretty_generate(courses))}



