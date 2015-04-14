var xPos = [];
var yPos = [];
var sound, amplitude;
var lifespan;
var radius;
var hue;
var a = 0;
var button;
var bg = true;
var osc;
var freq;
var canvas;
var redraw;

function setup() {
    "use strict";
    colorMode(HSB, 100);
    canvas = createCanvas(500, 500);
    canvas.parent('canvas-container');
    background(0);
    guiSetup();


    //	 button1.parent('button-container');

}




function draw() {

    //        freq = map(yPos[0], 0, height, 200, 300);

    bg = document.getElementById("redrawOn").checked;

    if (bg) {
        background(0);
    }
    //        osc.freq(freq);


    stroke(0);
    radius = radSlider.value()
    fluctuator(radius);
    if (xPos.length > 0) {
        console.log(xPos.length)
    }
}

function mouseDragged() {
    if (mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height) {

        xPos.push(mouseX);
        yPos.push(mouseY);
    }
    // console.log(xPos, yPos)

}


function guiSetup() {


    radSlider = createSlider(10, 500);
    radSlider.parent("radius");
    symSlider = createSlider(1, 4, 4);
    symSlider.parent("symmetry");
    xVelSlider = createSlider(-10, 10, 0);
    xVelSlider.parent("xvel");
    yVelSlider = createSlider(-10, 10, 0);
    yVelSlider.parent("yvel");
    aVelSlider = createSlider(-20, 20, 0);
    aVelSlider.parent("avel");
    hueSlider = createSlider(0, 100);
    hueSlider.parent("hue");
    satSlider = createSlider(0, 100, 90);
    satSlider.parent("sat");
    briSlider = createSlider(0, 100, 80);
    briSlider.parent("bri");
    lengthSlider = createSlider(0, 300);
    lengthSlider.parent("len");
    shapeSlider = createSlider(0, 2, 2);
    shapeSlider.parent("shape");









}

function mousePressed() {
    //     osc.stop(); 
    //    osc.start();

}

function mouseReleased() {


}

function fluctuator(size, rec) {
    var shapeDepth = shapeSlider.value();
    hueVal = hueSlider.value();
    var satVal = satSlider.value();
    var briVal = briSlider.value();
    var symPlanes = symSlider.value();
    var chainLength = lengthSlider.value();
    for (var i = 0; i < xPos.length; i++) {

        xPos[i] += xVelSlider.value() / 10;
        yPos[i] += yVelSlider.value() / 10;
        if (yPos[0] > height + radius || xPos[0] > width + radius || yPos[0] <
            0 - radius || xPos[0] < 0 -
            radius ||
            xPos.length > chainLength) {
            yPos.shift();
            xPos.shift();

        }

        rectMode(CENTER);
        lifespan = 255;
        lifespan -= 1;
        strokeWeight(0.5);
        // noStroke();

        push();
        scale(-1);
        translate(xPos[i], yPos[i]);
        rotate(a);

        fill(noise(yPos[i] / 1000) * (hueVal), satVal, briVal);
        if (shapeDepth >= 1) {
            rect(0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000),
                noise(yPos[i] / 10) * size *
                cos(a / 1000));

        }
        if (shapeDepth <= 1) {
            ellipse(0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000),
                noise(yPos[i] / 10) * size *
                cos(a /
                    1000));

        }
        pop();
        push();

        translate(xPos[i], yPos[i]);
        rotate(a);

        fill(noise(yPos[i] / 1000) * (hueVal), satVal, briVal);
        if (shapeDepth >= 1) {
            rect(0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000),
                noise(yPos[i] / 10) * size *
                cos(a / 1000));

        }
        if (shapeDepth <= 1) {
            ellipse(0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000),
                noise(yPos[i] / 10) * size *
                cos(a / 1000));

        }
        pop();
        if (symPlanes > 1) {
            push();

            fill(noise(yPos[i] / 1000) * (hueVal), satVal, briVal)
            translate(width - xPos[i], yPos[i]);

            rotate(-a);
            if (shapeDepth >= 1) {
                rect(0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000),
                    noise(yPos[i] / 10) * size *
                    cos(a / 1000));
            }
            if (shapeDepth <= 1) {
                ellipse(0, 0, noise(yPos[i] / 10) * size * sin(millis() /
                        1000), noise(yPos[i] / 10) *
                    size * cos(a / 1000));
            }

            pop();
        }
        a += 0.0001 * aVelSlider.value();
        if (symPlanes > 2) {
            fill(noise(yPos[i] / 100) * (hueVal), satVal, briVal)
            push();
            translate(yPos[i], xPos[i]);
            rotate(a);

            if (shapeDepth >= 1) {
                rect(0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000),
                    noise(yPos[i] / 10) * size * cos(millis() / 1000));
            }
            if (shapeDepth <= 1) {
                ellipse(0, 0, noise(yPos[i] / 10) * size * sin(millis() /
                        1000),
                    noise(yPos[i] / 10) * size * cos(millis() / 1000));
            }
            pop();



            push();
            translate(width - yPos[i], xPos[i])
            rotate(-a);
            if (shapeDepth >= 1) {
                rect(0, 0, noise(yPos[i] / 10) * size * sin(millis() / 1000),
                    noise(yPos[i] / 10) * size *
                    cos(
                        millis() / 1000));
            }
            if (shapeDepth <= 1) {
                ellipse(0, 0, noise(yPos[i] / 10) * size * sin(millis() /
                        1000), noise(yPos[i] / 10) *
                    size * cos(
                        millis() / 1000));
            }
            pop();
        }
    }

}
