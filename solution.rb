require 'date'

class Photo
  def solution(s)
    photos = s.split("\n")
    photo_info = Array.new
    result = Array.new
    final_result = Array.new

    # Parse photo data
    photos.each do |p|
      photo_info << {
        name: p.split(', ')[0].strip, 
        city: p.split(', ')[1].strip,
        date: DateTime.parse(p.split(', ')[2].strip),
        extension: p.split(', ')[0].strip.split('.').last.strip,
        original: p
      }
    end

    grouped_photos = photo_info.group_by { |photo| photo[:city] }

    grouped_photos.each do |_city, photos|
      photos.sort_by! { |photo| [photo[:date], photo[:name]] }
    end

    grouped_photos.each do |_city, photos|
      photos.each_with_index do |photo, index|
        result << {
          new_name: "#{photo[:city]}#{(index + 1).to_s.rjust(photos.length.to_s.length, '0')}.#{photo[:extension]}",
          original_name: photo[:original]
        }
      end
    end

    s.split("\n").each do |s2|
      final_result << result.find{ |x| x[:original_name] == s2 }[:new_name]
    end

    final_result.join("\n")
  end
end
