container = new Layer
	width: 1280, height: 800
	
bg = new BackgroundLayer 
	x:0, y:0, width:1280, height:800, image:"images/mob_base.png"

bg.on Events.TouchStart, ->
	cust.animate
		properties:
			x: custEnd
		curve: "spring(400,40,0)"
	keypad.opacity = 1
	buttons[11].backgroundColor = "#555"
	buttons[11].html = "Skip"
	check.opacity = 0
	
custEnd = 90	
	
cust = new Layer 
	x:1280, y:32, width:1199, height:704, image:"images/Bitmap.png"

apply = new Layer 
	x: 800, y: 610, width: 400, height: 70, backgroundColor: "transparent"
apply.superLayer = cust

apply.on Events.TouchStart, ->
	cust.animate
		properties:
			x: 1280
		curve: "spring(400,40,0)"
	apply.sendToBack()
apply.sendToBack()		
keypad = new Layer
	x: 340, y:80, width: 850, height: 600, backgroundColor: "#fff"

keypad.superLayer = cust

label = new Layer 
	width: 200, height: 50, backgroundColor:"transparent"
label.style = {
		"color" :"#D87028"
		"fontSize":"14px"
		"fontFamily":"FreightSans Pro"
		"fontWeight" : "bold"
	}
label.html = "TODAY'S PURCHASE"
label.superLayer = keypad


field = new Layer
	y: 40, width: 790, backgroundColor: "transparent"
field.style = {
	"border":"1px solid #ddd"
	}
field.superLayer = keypad

numbers = []
numberTot = ""

refreshTot = ->
	numberTot = []
	for i in [0...numbers.length]
		numberTot += numbers[i]	
	field.html = ""
	field.html = numberTot

removeNumber = ->	
	numbers.pop()
	refreshTot()

		
del = new Layer 
	x:0, y:490, width:250, height:100, backgroundColor: "transparent"
del.superLayer = keypad
del.on Events.TouchStart, ->
	removeNumber()

field.style = {
	"border" : "1px solid #ddd"
	"color" : "#888"
	"fontSize" : "40px"
	"textAlign" : "right"
	"lineHeight" : "100px"
	"paddingRight":"40px"
	}
field.html = "0.00"

num = 1
bWidth = 250
numTag = ""
tot = 0
buttons = []
for x in [0...4]
	for i in [0...3]
		tot++
		numTag = num
		
		button = new Layer
				x: i*(bWidth+20), y: x* 110+160, width: bWidth, height: 100, backgroundColor: "#fff"
		num++	
		if num == 10
			num = 0
		
		button.html = numTag
		
		button.style = {
			"border" : "1px solid #ddd"
			"color" : "#888"
			"fontSize" : "40px"
			"textAlign" : "center"
			"lineHeight" : "100px"
			#"borderRadius": "3px"
 		}
		
		if tot == 10
			button.html = ""
			button.image = "images/del.png"
			button.on Events.TouchEnd, ->
				removeNumber()
				
		if tot == 11
			button.html = 0
 
		if tot == 12
			button.html = "Skip" 
			button.style["fontWeight"] = "lighter"
			button.backgroundColor = "#555"
			button.style["color"] = "#fff"
			button.on Events.TouchStart,->
				this.backgroundColor="#9CD718"
				keypad.animate
					properties:
						opacity: 0
					curve: "spring(400,40,10)"
				apply.bringToFront()
			button.on Events.TouchEnd,->
				this.backgroundColor="#80B90A"
		else
			button.on Events.TouchStart,->
				buttons[11].backgroundColor = "#80B90A"
				buttons[11].html = ""
				check.opacity = 1
				this.backgroundColor="#eee"
				numbers.push(this.html)
				refreshTot()
			button.on Events.TouchEnd,->
				this.backgroundColor="#fff"
					
		button.superLayer = keypad
		buttons.push(button) 
		del.bringToFront()

check = new Layer 
	x:540, y:490, width:250, height:100, image:"images/check.png", opacity: 0
check.superLayer = keypad

bg.superLayer = container
cust.superLayer = container