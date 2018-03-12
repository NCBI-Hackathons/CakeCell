def shrinkImage(image_file, x, y):
	import Image
	im = Image.open(image_file)
	size = x, y
	im.thumbnail(size, Image.ANTIALIAS)
	save_name = image_file.split('.')[0] + 'SHRINK.jpg'
	im.save(save_name, 'JPEG')
