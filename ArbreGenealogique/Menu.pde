


class bouton {
  
  
  float xB, yB, dimTxtB, corrXB;
  int etatB, effetB;
  String texteB;
  boolean testB;
  color contour = color(0, 0, 0);


  bouton(float xBI, float yBI, float dimTxtBI, int etatBI, String texteBI, float corrXBI, boolean testBI, int effetBI) {
    xB = xBI;
    yB = yBI;
    etatB = etatBI;
    texteB = texteBI;
    dimTxtB = dimTxtBI;
    corrXB = corrXBI;
    testB = testBI;
    effetB = effetBI;
  }


  void affichageB() {
    if (etat == etatB) {
      pushStyle();
      strokeCap(ROUND);
      strokeWeight(dimTxtB/8);
      stroke(contour);
      fill(230);
      if (testB) {
        rect(xB+(mx(mouseX)-width/2), yB+(my(mouseY)-height/2), (texteB.length()+1)*dimTxtB/1.5-corrXB, dimTxtB*2);
        println(mx(mouseX)-width/2, my(mouseY)-height/2);
      } else {
        rect(xB, yB, (texteB.length()+1)*dimTxtB/1.5-corrXB, dimTxtB*2);
      }
      popStyle();

      pushStyle();
      noStroke();
      fill(0);
      textSize(dimTxtB);
      if (testB) {
        text(texteB, xB+dimTxtB/1.6+(mx(mouseX)-width/2), yB+1.5*dimTxtB+(my(mouseY)-height/2));
      } else {
        text(texteB, xB+dimTxtB/1.6, yB+1.5*dimTxtB);
      }
      popStyle();
    }
  }


  void animationB() {
    if (etat == etatB) {
      if (mx(mouseX) > xB && mx(mouseX) < xB+(texteB.length()+1)*dimTxtB/1.5-corrXB && my(mouseY) > yB && my(mouseY) < yB+dimTxtB*2) {
        contour = color(60, 50, 170);
        if (mouseClicked) {
          effetBouton(effetB);
        }
      } else {
        contour = color(0, 0, 0);
      }
    }
  }
  
  
}





class champ {
  
  
  float xC, yC, lxC, lyC;
  boolean testC;
  int etatC;
  boolean selectC = false;
  String texteC = "";
  String idC;
  
  
  champ(float xCI, float yCI, float lxCI, float lyCI, int etatCI, String idCI, boolean testCI) {
    xC = xCI;
    yC = yCI;
    lxC = lxCI;
    lyC = lyCI;
    testC = testCI;
    etatC = etatCI;
    idC = idCI;
  }


  void affichageC() {
    if (etat == etatC) {
      pushStyle();
      strokeCap(ROUND);
      strokeWeight(lyC/16);
      if (selectC) {
        stroke(250, 40, 25);
      } else {
        stroke(0);
      }
      fill(255);
      if (testC) {
        rect(xC+mx(mouseX)-width/2, yC+my(mouseY)-height/2, lxC, lyC);
        println(mx(mouseX)-width/2, my(mouseY)-height/2);
      } else {
        rect(xC, yC, lxC, lyC);
      }
      popStyle();

      pushStyle();
      fill(0);
      textSize(lyC*0.5);
      text(texteC, xC+lyC*0.3, yC+lyC*0.6);
      popStyle();
    }
  }


  void clicC() {
    if (mouseClicked && etat == etatC) {
      if (mx(mouseX) > xC && mx(mouseX) < xC+lxC && my(mouseY) > yC && my(mouseY) < yC+lyC) {
        selectC = true;
      } else {
        selectC = false;
        verifEspaceC();
      }
    }
  }


  void toucheC() {
    if (keyPressedB && keyReleased && selectC) {
      if (touche != BACKSPACE) { 
        texteC += touche;
        keyReleased = false;
        keyPressedB = false;
      } else if (texteC.length() > 0) {
        String textePC = "";
        for (int i = 0; i < texteC.length()-1; i ++) {
          textePC += texteC.charAt(i);
        }
        texteC = textePC;
        keyReleased = false;
        keyPressedB = false;
      }
    }
  }
  
  
  void verifEspaceC(){
    if(texteC.length() > 1){
      if(texteC.charAt(0) == ' '){
        String texteCP = "";
        for(int i = 1; i < texteC.length() ; i ++){
          texteCP += texteC.charAt(i);
        }
        texteC = texteCP;
      }
    }
  }
  
}
