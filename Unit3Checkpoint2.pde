// Palette of colors
color cream        = #FCFBE3;
color lightBrown   = #DDCAAA;
color mediumBrown  = #BC8542;
color darkBrown    = #9F642C;
color darkestBrown = #6E3722;
color white        = #FFFFFF;

// Variables for color selection
color selectedColor;

void setup() {
  size(800, 800);
  strokeWeight(5);
  stroke(darkestBrown);
  selectedColor = darkBrown;
}

void draw() {
  background(cream);
  
  
  

  // Buttons
  tactile(50, 200, 100, 50, lightBrown);
  tactile(50, 300, 100, 50, mediumBrown);
  tactile(50, 400, 100, 50, darkBrown);

  // Indicator for selected color
  stroke(darkestBrown);
  fill(selectedColor);
  square(300, 100, 400);
}


void tactile(int x, int y, int w, int h, color buttonColor) {
  if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
    stroke(white);
    fill(lerpColor(buttonColor, white, 0.3));  
  } else {
    stroke(darkestBrown);
    fill(buttonColor);
  }
  rect(x, y, w, h);
}

void mouseReleased() {

  if (mouseX > 50 && mouseX < 150) {
    if (mouseY > 200 && mouseY < 250) {
      selectedColor = lightBrown;
  } else if (mouseY > 300 && mouseY < 350) {
      selectedColor = mediumBrown;
  } else if (mouseY > 400 && mouseY < 450) {
      selectedColor = darkBrown;
    }
  }
}
