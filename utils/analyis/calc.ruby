require "csv"

filepath=ARGV[0]
diffpath=filepath+"_diff.csv"

file = File.open(diffpath, "w")

sum=0.0
max=0.0
min=99999999999.0
count=0
start=0.0
CSV.foreach(filepath) do |row|
	if count > 0 then
		diff=row[2].to_f - row[1].to_f
		if diff > max then
			max = diff
		end
		if diff < min then
			min = diff
		end
		sum = sum + diff
		if start == 0 then
			start = row[0].to_f
		end
		msg = sprintf("%f, %f, %f, %f,\n", (row[0].to_f - start)/1000000, row[1].to_f , row[2].to_f, row[2].to_f - row[1].to_f)
		file.write(msg)
	end
	count = count + 1
end
file.close

num=count-1

ave = (sum/num)

count=0
std_sum=0.0
CSV.foreach(filepath) do |row|
	if count > 0 then
		diff=row[2].to_f - row[1].to_f
		std_sum = std_sum + ( (diff - ave) ** 2 )
	end
	count = count + 1
end
num=count-1
std = Math.sqrt(std_sum / num)

puts sprintf("ave %f msec", ave * 1000)
puts sprintf("min %f msec", min * 1000)
puts sprintf("max %f msec", max * 1000)
puts sprintf("std %f msec", std * 1000)
