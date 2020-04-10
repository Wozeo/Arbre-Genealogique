

class profils {

  float xP, yP;
  String prenomP, nomP, naissanceP;
  int idP, ttextP;
  int liensP[];
  boolean selectP = false;
  boolean deplacer = false;
  boolean lier = false;
  float txtSize = 25;

  profils(float xPI, float yPI, String prenomPI, String nomPI, String naissancePI, int idPI, int ttextPI, int liensPI[]) {
    xP = xPI;
    yP = yPI;
    prenomP = prenomPI;
    nomP = nomPI;
    naissanceP = naissancePI;
    idP = idPI;
    ttextP = ttextPI;
    liensP = liensPI;
  }


  void affichageP() {
    if (data[idP].length() > 0) {

      pushStyle();
      if (selectP) {

        pushStyle();
        stroke(0);
        strokeWeight(x700(3));
        if (deplacer) {
          stroke(255, 0, 0);
        } else {
          stroke(0);
        }
        rect(xP, yP+y700(110), x700(ttextP*txtSize/1.7)/3, y700(50));
        stroke(0);
        rect(xP+x700(ttextP*txtSize/1.7)/3, yP+y700(110), x700(ttextP*txtSize/1.7)/3, y700(50));
        if (lier) {
          stroke(255, 0, 0);
        } else {
          stroke(0);
        }
        rect(xP+2*x700(ttextP*txtSize/1.7)/3, yP+y700(110), x700(ttextP*txtSize/1.7)/3, y700(50));
        fill(0);
        textSize(y700(40));
        text("D", xP+x700(ttextP*txtSize/1.7)/7, yP+y700(150));
        text("M", xP+x700(ttextP*txtSize/1.7)/7+x700(ttextP*txtSize/1.7)/3, yP+y700(150));
        text("L", xP+x700(ttextP*txtSize/1.7)/7+2*x700(ttextP*txtSize/1.7)/3, yP+y700(150));
        popStyle();
      }

      if (selectP) {
        stroke(50);
        strokeWeight(x700(10));
      } else {
        stroke(0);
        strokeWeight(x700(5));
      }
      fill(255);
      rect(xP, yP, x700(ttextP*txtSize/1.7), y700(110));
      popStyle();

      pushStyle();
      fill(0);
      stroke(0);
      textSize(txtSize);
      text("Prénom : "+prenomP, xP+10, yP+35);
      text("Nom : "+nomP, xP+10, yP+65);
      text("Naissance : "+naissanceP, xP+10, yP+95);
      popStyle();
    }
  }


  void afflier() {
    pushStyle();
    if (liensP.length > 0) {
      for (int i = 0; i < liensP.length; i ++) {
        stroke(0);
        strokeWeight(5);
        line(xP+x700(ttextP*txtSize/1.7)/2, yP+y700(110)/2, profil[liensP[i]].xP+x700(ttextP*txtSize/1.7)/2, profil[liensP[i]].yP+y700(110)/2);
      }
    }
    popStyle();
  }


  void sourisP() {

    if (etat == 0 ) {
      if (mouseClicked) {
        if ( mx(mouseX) > xP && mx(mouseX) < xP + x700(ttextP*txtSize/1.7) && my(mouseY) > yP && my(mouseY) < yP+y700(110)) {
          selectP = true;
        } else if (( mx(mouseX) > xP && mx(mouseX) < xP + x700(ttextP*txtSize/1.7) && my(mouseY) > yP && my(mouseY)< yP+y700(160) && selectP) == false) {
          selectP = false;
        } else if (selectP) {
          if (my(mouseY) > yP+y700(110) && my(mouseY) < yP+y700(160) && mx(mouseX) > xP  && mx(mouseX) < xP + x700(ttextP*txtSize/1.7)/3) {//deplacer
            deplacer = true;
          } else if (my(mouseY) > yP+y700(110) && my(mouseY) < yP+y700(160) && mx(mouseX) > xP+x700(ttextP*txtSize/1.7)/3  && mx(mouseX) < xP + 2*x700(ttextP*txtSize/1.7)/3) {//modifier
          } else if (my(mouseY) > yP+y700(110) && my(mouseY) < yP+y700(160) && mx(mouseX) > xP+2*x700(ttextP*txtSize/1.7)/3  && mx(mouseX) < xP + x700(ttextP*txtSize/1.7)) {//lier
            lier = true;
          }
        }
      }
      if (deplacer) {
        xP = (mx(mouseX)-x700(ttextP*txtSize/1.7)/2);
        yP = (my(mouseY)-y700(110)/2);
        if (mousePressed == true && mouseButton == RIGHT) {
          deplacer = false;
        }
      }
    }
  }


  void lierP() {
    if (lier) {
      if (mouseClicked) {
        if ((mx(mouseX) > xP && mx(mouseX) < xP + x700(ttextP*txtSize/1.7) && my(mouseY) > yP && my(mouseY) < yP+y700(160)) == false) {
          lier = false;
          int lierAvec = 0;
          boolean lierAv = false;
          for (int i = 0; i < profil.length; i ++) {
            if (i != idP) {
              if (mx(mouseX) > profil[i].xP && mx(mouseX) < profil[i].xP+x700(profil[i].ttextP*txtSize/1.7) && my(mouseY) > profil[i].yP && my(mouseY) < profil[i].yP + y700(110)) {
                lierAv = true;
                lierAvec = i;
              }
            }
          }
          if (lierAv) {
            int liensPP[] = new int[liensP.length+1];
            if (liensP.length > 0) {
              for (int k = 0; k < liensP.length; k ++) {
                liensPP[k] = liensP[k];
              }
            }
            liensPP[liensP.length] = lierAvec;
            liensP = liensPP;
          }
        }
      }
    }
  }
}
