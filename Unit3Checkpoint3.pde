
class Slider {
  float x, y, w, h;
  float minVal, maxVal;
  float value;
  boolean dragging = false;

  Slider(float x, float y, float w, float h, float minVal, float maxVal, float startVal) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.minVal = minVal;
    this.maxVal = maxVal;
    this.value = startVal;
  }

  void update() {
    if (dragging) {
      float newX = constrain(mouseX, x, x + w);
      value = map(newX, x, x + w, minVal, maxVal);
    }
  }

  void display() {
    // Slider track
    stroke(0);
    line(x, y + h / 2, x + w, y + h / 2);

    // Slider handle
    float handleX = map(value, minVal, maxVal, x, x + w);
    fill(150);
    if (dragging) fill(100); // Darker when dragged
    ellipse(handleX, y + h / 2, h, h);
  }

  boolean overHandle() {
    float handleX = map(value, minVal, maxVal, x, x + w);
    return dist(mouseX, mouseY, handleX, y + h / 2) < h / 2;
  }
}

Slider brightnessSlider;

void setup() {
  size(800, 400);
  brightnessSlider = new Slider(100, 200, 300, 20, 0, 255, 127);
}

void draw() {
  background(brightnessSlider.value);
  brightnessSlider.update();
  brightnessSlider.display();
}

void mousePressed() {
  if (brightnessSlider.overHandle()) brightnessSlider.dragging = true;
}

void mouseReleased() {
  brightnessSlider.dragging = false;
}
