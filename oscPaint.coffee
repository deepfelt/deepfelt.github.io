xPos = []
yPos = []
sound = undefined
amplitude = undefined
lifespan = undefined
radius = undefined
a = 0
button = undefined
bg = true
osc = undefined
freq = undefined
canvas = undefined
redraw = undefined
stroke_weight = undefined
stroke_alpha = undefined
xVel = undefined
yVel = undefined
aVel = undefined
hueVal = undefined
satVal = undefined
briVal = undefined
alphaVal = undefined
chainLength = undefined
shadows = false
hueJitter = undefined
sizeJitter = undefined
shaDepth = undefined


setup = ->
  'use strict'
  colorMode HSB, 100
  canvas = createCanvas(screen.availWidth / 2, screen.availHeight * 0.75)
  canvas.parent 'canvas-container'
  background 0
  guiSetup()
  #	 button1.parent('button-container');
  return

draw = ->
  #        freq = map(yPos[0], 0, height, 200, 300);
  bg = document.getElementById('redrawOn').checked
  shadows = document.getElementById('shadowsOn').checked
  if bg
    background 0
  #        osc.freq(freq);
  radius = radSlider.value()
  fluctuator radius
  #    if (xPos.length > 0) {
  #//        console.log(xPos.length)
  #    }
  #  create range slider labels
  $('#radlabel').text 'radius: ' + @radius
  $('#xvlabel').text 'x velocity: ' + @xVel
  $('#yvlabel').text 'y velocity: ' + @yVel
  $('#avlabel').text 'rotation speed: ' + @aVel
  $('#swtlabel').text 'Stroke Weight: ' + @stroke_weight
  $('#skalabel').text 'Stroke Opacity: ' + @stroke_alpha + '%'
  $('#huelabel').text 'Hue: ' + int(@hueVal / 2.55) + '%'
  $('#satlabel').text 'Saturation: ' + int(@satVal) + '%'
  $('#brilabel').text 'Brightness: ' + int(@briVal) + '%'
  $('#alphalabel').text 'Fill Opacity: ' + int(@alphaVal) + '%'
  $('#lenlabel').text 'Chain Length: ' + @chainLength
  $('#jitterlabel').text 'Hue Jitter: ' + 1100 - (@hueJitter)
  $('#shadepthlabel').text 'Shadow Depth: ' + @shaDepth
  return

mouseDragged = ->
  if mouseX > 0 and mouseX < width and mouseY > 0 and mouseY < height
    xPos.push mouseX
    yPos.push mouseY
  # console.log(xPos, yPos)
  return

guiSetup = ->
  radSlider = createSlider(10, 500)
  radSlider.parent 'radius'
  symSlider = createSlider(1, 4, 4)
  symSlider.parent 'symmetry'
  xVelSlider = createSlider(-10, 10, 0)
  xVelSlider.parent 'xvel'
  yVelSlider = createSlider(-10, 10, 0)
  yVelSlider.parent 'yvel'
  aVelSlider = createSlider(-20, 20, 0)
  aVelSlider.parent 'avel'
  lengthSlider = createSlider(0, 300)
  lengthSlider.parent 'len'
  shapeSlider = createSlider(0, 2, 2)
  shapeSlider.parent 'shape'
  hueJitterSlider = createSlider(1, 1000)
  hueJitterSlider.parent 'huejitter'
  hueSlider = createSlider(0, 255)
  hueSlider.parent 'hue'
  satSlider = createSlider(0, 100, 90)
  satSlider.parent 'sat'
  briSlider = createSlider(0, 100, 80)
  briSlider.parent 'bri'
  alphaSlider = createSlider(0, 100, 100)
  alphaSlider.parent 'alpha'
  strokeSlider = createSlider(0, 100, 2)
  strokeSlider.parent 'swt'
  strokeAlpha = createSlider(0, 100, 100)
  strokeAlpha.parent 'skalpha'
  shadowSlider = createSlider(0, 30)
  shadowSlider.parent 'shadepth'
  return

mousePressed = ->
  #     osc.stop(); 
  #    osc.start();
  return

mouseReleased = ->

fluctuator = (size, rec) ->
  ctx = document.getElementById('defaultCanvas').getContext('2d')
  shaDepth = shadowSlider.value() / 100
  if shadows
    ctx.shadowColor = '#3c3c39'
    ctx.shadowBlur = radius * .02
    ctx.shadowOffsetY = radius * shaDepth
  hueJitter = 1100 - hueJitterSlider.value()
  shapeDepth = shapeSlider.value()
  hueVal = hueSlider.value()
  satVal = satSlider.value()
  briVal = briSlider.value()
  symPlanes = symSlider.value()
  chainLength = lengthSlider.value()
  alphaVal = alphaSlider.value()
  stroke_weight = strokeSlider.value() / 10
  strokeWeight stroke_weight
  stroke_alpha = strokeAlpha.value()
  xVel = xVelSlider.value() / 10
  yVel = yVelSlider.value() / 10
  aVel = aVelSlider.value()
  stroke 0, stroke_alpha
  i = 0
  while i < xPos.length
    xPos[i] += xVel
    yPos[i] += yVel
    if yPos[0] > height + radius or xPos[0] > width + radius or yPos[0] < 0 - radius or xPos[0] < 0 - radius or xPos.length > chainLength
      yPos.shift()
      xPos.shift()
    rectMode CENTER
    lifespan = 255
    lifespan -= 1
    # noStroke();
    push()
    scale -1
    translate xPos[i], yPos[i]
    rotate a
    fill noise(yPos[i] / hueJitter) * hueVal, satVal, briVal, alphaVal
    fill noise(yPos[i] / 1000) * hueVal, satVal, briVal, alpha
    if shapeDepth >= 1
      rect 0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000), noise(yPos[i] / 10) * size * cos(a / 1000)
    if shapeDepth <= 1
      ellipse 0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000), noise(yPos[i] / 10) * size * cos(a / 1000)
    pop()
    push()
    translate xPos[i], yPos[i]
    rotate a
    fill noise(yPos[i] / hueJitter) * hueVal, satVal, briVal, alphaVal
    fill noise(yPos[i] / 1000) * hueVal, satVal, briVal, alpha
    if shapeDepth >= 1
      rect 0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000), noise(yPos[i] / 10) * size * cos(a / 1000)
    if shapeDepth <= 1
      ellipse 0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000), noise(yPos[i] / 10) * size * cos(a / 1000)
    pop()
    if symPlanes > 1
      push()
      fill noise(yPos[i] / hueJitter) * hueVal, satVal, briVal, alphaVal
      fill noise(yPos[i] / 1000) * hueVal, satVal, briVal, alpha
      translate width - (xPos[i]), yPos[i]
      rotate -a
      if shapeDepth >= 1
        rect 0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000), noise(yPos[i] / 10) * size * cos(a / 1000)
      if shapeDepth <= 1
        ellipse 0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000), noise(yPos[i] / 10) * size * cos(a / 1000)
      pop()
    a += 0.0001 * aVel
    if symPlanes > 2
      fill noise(yPos[i] / hueJitter) * hueVal, satVal, briVal, alphaVal
      fill noise(yPos[i] / 100) * hueVal, satVal, briVal, alpha
      push()
      translate yPos[i], xPos[i]
      rotate a
      if shapeDepth >= 1
        rect 0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000), noise(yPos[i] / 10) * size * cos(millis() / 1000)
      if shapeDepth <= 1
        ellipse 0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000), noise(yPos[i] / 10) * size * cos(millis() / 1000)
      pop()
      push()
      translate width - (yPos[i]), xPos[i]
      rotate -a
      if shapeDepth >= 1
        rect 0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000), noise(yPos[i] / 10) * size * cos(millis() / 1000)
      if shapeDepth <= 1
        ellipse 0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000), noise(yPos[i] / 10) * size * cos(millis() / 1000)
      pop()
    i++
  return