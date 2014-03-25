
packageName = ARGV[0]
activityName = ARGV[1]
apkPath = ARGV[2]
if (packageName==nil or activityName==nil or apkPath==nil) then
	abort("ABORT ! Expected Parameters : PackageName ActivityName ApkPath")
end


list = `adb devices`

deviceIds = []
list.lines.to_a[1..-1].each do |line|
	match = line.match(/(\S*)\t\S*/)
	if (match!=nil) then
		deviceIds << match[1]
	end
end

for deviceId in deviceIds do
	#TODO uninstall before
	print `adb -s #{deviceId} install -r #{apkPath}`

	print `adb -s #{deviceId} shell am start -n #{packageName}/.#{activityName}`
end

