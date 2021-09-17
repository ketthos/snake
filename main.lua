local snake = {}
snake.x = 0
snake.y = 0
snake.direction = "start"
snake.speed = 150
snake.longueur = {}

local fruits = {}

local scores = 0

function AjouteLongueur()
	local snake = {}
	table.insert(snake.longueur, snake)
end

function CheckCollide(a, b)
	aw, ah = 10, 10
	bw, bh = b.images[0]:getDimensions()
	return a.x < (b.x + bw) and 
		b.x < (a.x+aw) and 
		a.y < (b.y + bh) and
		b.y < (a.y + ah) 
		
end

function DrawScore(text)
	--local font = love.graphics.newFont(24)
	local textWidth = font:getWidth(text)
	local textHeight = font:getHeight()

	love.graphics.print(text, font, largeur/2, 0, 0, 1, 1, textWidth/2)
end

function AjoutFruit()
	local fruit = {}
	fruit.x = love.math.random(largeur)
	fruit.y = love.math.random(hauteur)
	fruit.images = {}
	fruit.images[0] = love.graphics.newImage('images/pomme.png')
	fruit.curFruit = 0
	table.insert(fruits, fruit)
end

function love.load()
	largeur = love.graphics.getWidth()
	hauteur = love.graphics.getHeight()
	snake.x = math.floor(largeur / 2)
	snake.y = math.floor(hauteur / 2)
	font = love.graphics.newFont(24)
	--AjoutFruit()
	timer = 0
end

function love.draw()
	cellSize = 10
	DrawScore("Scores: "..scores)
	love.graphics.rectangle("fill", snake.x, snake.y , 10, 10)
	for k,v in ipairs(fruits) do
		love.graphics.draw(v.images[0], v.x, v.y, 0, 1, 1, v.images[0]:getWidth(), v.images[0]:getHeight())
	end

end

function love.update(dt)
	timer = timer + dt
	if timer >= 5 then
		timer = 0
		table.remove(fruits)
		snake.speed = snake.speed + 10
		AjoutFruit()
	end

	for i=1,#fruits do
		if CheckCollide(snake, fruits[i]) == true then
			scores = scores + 1
			table.remove(fruits)
		end
	end

	if snake.direction == "left" then
		snake.x = snake.x - math.floor((snake.speed * dt))
	end
	if snake.direction == "right" then
		snake.x = snake.x + math.floor((snake.speed * dt))

	end
	if snake.direction == "top" then
		snake.y = snake.y - math.floor((snake.speed * dt))
	end
	if snake.direction == "down" then
		snake.y = snake.y + math.floor((snake.speed * dt))
	end

end

function love.keypressed(key)
	if key=='escape' then
		love.event.quit()
	end
	if key == "left" then
		snake.direction = "left"
	end
	if key == "right" then
		snake.direction = "right"
	end
	if key == "up" then
		snake.direction = "top"
	end
	if key == "down" then
		snake.direction = "down"
	end
end
