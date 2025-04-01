PImage alanWang;
color selectedColor = color(0);
float brushSize = 5;
boolean stampMode = false;
PGraphics canvas;
float sliderY = 475;

void setup() {
  size(800, 600);
  alanWang = loadImage("alan_wang.png");
  alanWang.resize(50, 50);
  canvas = createGraphics(width, height);
  clearCanvas();
}

void draw() {
  background(245, 245, 220);
  image(canvas, 0, 0);

  // UI Panel
  fill(0);
  rect(0, 0, 100, height, 15);

  drawColorPalette();
  drawSlider();
  drawButtons();

  if (mousePressed && mouseX > 100) { // Prevent drawing over buttons
    canvas.beginDraw();
    if (stampMode) {
      canvas.image(alanWang, mouseX - 25, mouseY - 25);
    } else {
      canvas.stroke(selectedColor);
      canvas.strokeWeight(brushSize);
      canvas.line(pmouseX, pmouseY, mouseX, mouseY);
    }
    canvas.endDraw();
  }
}

// **Tactile UI Elements**
void tactile(float x, float y, float r, String label) {
  stroke(0);
  noFill();
  ellipse(x, y, r * 2, r * 2);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  text(label, x, y);
}

// **Color Palette**
void drawColorPalette() {
  color[] colors = {color(255, 0, 0), color(255, 165, 0), color(255, 255, 0),
                    color(0, 255, 0), color(0, 0, 255), color(75, 0, 130), color(148, 0, 211)};
  for (int i = 0; i < colors.length; i++) {
    tactile(50, 100 + i * 45, 20, "");
    fill(colors[i]);
    ellipse(50, 100 + i * 45, 35, 35);
  }
}

// **Smooth Slider (White Background)**
void drawSlider() {
  fill(255);
  rect(35, 400, 10, 150, 5);
  fill(0);
  ellipse(40, sliderY, 15, 15);
}

// **Circular Buttons (Top Right)**
void drawButtons() {
  image(alanWang, 25, 20);
  tactile(width - 50, 50, 20, "C");
  tactile(width - 50, 110, 20, "S");
}

// **Mouse Released Actions**
void mouseReleased() {
  if (mouseX > 30 && mouseX < 70 && mouseY > 80 && mouseY < 400) { // Select color
    int index = (mouseY - 100) / 45;
    color[] colors = {color(255, 0, 0), color(255, 165, 0), color(255, 255, 0),
                      color(0, 255, 0), color(0, 0, 255), color(75, 0, 130), color(148, 0, 211)};
    if (index >= 0 && index < colors.length) {
      selectedColor = colors[index];
      stampMode = false;
    }
  } else if (dist(mouseX, mouseY, width - 50, 50) < 20) { // Clear
    clearCanvas();
  } else if (dist(mouseX, mouseY, width - 50, 110) < 20) { // Save
    saveCanvas();
  } else if (mouseX > 25 && mouseX < 75 && mouseY > 20 && mouseY < 70) { // Stamp
    stampMode = true;
  }
}

// **Slider Dragging**
void mouseDragged() {
  if (mouseX > 30 && mouseX < 50 && mouseY > 400 && mouseY < 550) {
    sliderY = constrain(mouseY, 400, 550);
    brushSize = map(sliderY, 550, 400, 5, 50);
  }
}

// **Canvas Controls**
void clearCanvas() {
  canvas.beginDraw();
  canvas.background(245, 245, 220);
  canvas.endDraw();
}

void saveCanvas() {
  canvas.save("myDrawing.png");
}
