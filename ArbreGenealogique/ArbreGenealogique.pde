

//Affichage
float zoom = 1;
float xCam = 0;
float yCam = 0;
float xCama = 0;
float yCama = 0;
float vDeplaCam = 5;


//Touches, Souris
boolean keyReleased = true;
boolean keyPressedB = false;
int t = 0;
boolean touches[] = new boolean[256];
boolean mouseClicked = false;
PVector souris = new PVector(0, 0);
char touche = 'a';


//Profil
profils profil[] = new profils[0];
String data[];
String separateur = ",";
String elmNeutre = "-";
String none = "rien";


//Menu
int nEtat = 2;
int etat = 0;
int nBoutons = 2;
bouton boutons[] = new bouton[nBoutons];
int nChamps = 3;
champ champs[] = new champ[nChamps];
int champsAjouts[] = {0, 1, 2};


void setup() {
  boutons[0] = new bouton(x700(125), y700(635), height/28, 2, "Ajouter", 0, false, 1);
  boutons[1] = new bouton(x700(480), y700(635), height/28, 2, "Annuler", 0, false, 2);

  champs[0] = new champ(width/8+x700(45), y700(100), width/1.6+x700(110), height/16, 2, "prenom", false);
  champs[1] = new champ(width/8+x700(45), y700(150), width/1.6+x700(110), height/16, 2, "nom", false);
  champs[2] = new champ(width/8+x700(245), y700(200), width/1.6-x700(90), height/16, 2, "naissance", false);
}


void settings() {
  String parametres[] = loadStrings("parametre.txt");
  String ligne0[] = parametres[0].split(" ");
  size(int(ligne0[1]), int(ligne0[2]));
  chargeDonnee();
}


void draw() {
  affichage();
  for (int i = 0; i < boutons.length; i ++) {
    boutons[i].affichageB();
    boutons[i].animationB();
  }
  for (int i = 0; i < champs.length; i ++) {
    champs[i].affichageC();
    champs[i].clicC();
    champs[i].toucheC();
  }
  if (t < 20) {
    t ++;
  }
  if (etat == 0) {
    xCama = xCam;
    yCama = yCam;
  } else {
    xCam = 0;
    yCam = 0;
  }
  mouseClicked = false;
}


void keyPressed() {
  switch(keyCode) {
    case(32):// espace
    if (etat == 0) {
      etat = 2;
    } else if (etat == 1) {
      etat = 0;
      xCam = xCama;
      yCam = yCama;
    }
    break;
  }
  if (keyCode < 256) {
    touches[keyCode] = true;
  }
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e < 0) {
    zoom *= 1.1;
  } else if (e > 0) {
    zoom /= 1.1;
  }
}


void keyReleased() {
  keyReleased = true;
  if (keyCode < 256) {
    touches[keyCode] = false;
  }
}


void keyTyped() {
  touche = key;
  keyPressedB = true;
}


void mouseClicked() {
  mouseClicked = true;
  souris = new PVector(mouseX, mouseY);
  if (etat == 0 && profil.length > 0 && t >= 20) {
    saveProfils();
  }
}


void affichage() {
  switch(etat) {

    case(0):
    pushMatrix();
    translate(xCam, yCam);
    scale(zoom);
    background(255);

    if (profil.length > 0) {
      for (int i = 0; i < profil.length; i ++) {
        profil[i].afflier();
      }
    }

    if (profil.length > 0) {
      for (int i = 0; i < profil.length; i ++) {
        profil[i].affichageP();
        profil[i].sourisP();
        profil[i].lierP();
      }
    }
    if (touches[37]) {
      xCam +=vDeplaCam;
    } 
    if (touches[38]) {
      yCam +=vDeplaCam;
    } 
    if (touches[39]) {
      xCam -=vDeplaCam;
    } 
    if (touches[40]) {
      yCam -=vDeplaCam;
    }
    popMatrix();
    break;
    case(1):
    background(215);
    break;
    case(2):
    background(100, 100, 200);
    pushStyle();
    fill(0);
    textSize(x700(25));
    text("Nouveau Profil", 255, 50);
    text("Prénom :", 10, 130);
    text("Nom :", 10, 180);
    text("Naissance (JJ/MM/AAAA) :", 10, 230);
    popStyle();
    break;
  }
}


void effetBouton(int effet) {
  switch(effet) {
    case(0)://nouveau profil
    etat = 2;
    break;

    case(1)://ajouter profil
    String total = "";
    for (int i = 0; i < champsAjouts.length; i ++) {
      if (champs[i].texteC == "") {
        champs[i].texteC = none;
      }
      total += champs[i].texteC;
      champs[i].texteC = "";
      total += separateur;
    }
    total += "0,0";
    ajoutPersonne(total);
    chargeDonnee();
    etat = 0;
    xCam = xCama;
    yCam = yCama;
    break;

    case(2):// annuler profil
    for (int i = 0; i < champsAjouts.length; i ++) {
      champs[i].texteC = "";
    }
    etat = 0;
    break;
  }
}


void ajoutPersonne(String ligne) {
  String donnee[] = loadStrings("donnee.txt");
  String donneeP[] = new String[donnee.length+1];
  if (donnee.length > 0) {
    for (int i = 0; i < donnee.length; i ++) {
      donneeP[i] = donnee[i];
    }
  }
  donneeP[donnee.length] = str(donnee.length)+separateur+ligne;
  saveStrings("donnee.txt", donneeP);
  chargeDonnee();
}


void chargeDonnee() {
  data = loadStrings("donnee.txt");
  placeData();
}


void placeData() {
  if (data.length > 0) {
    profil = new profils[data.length];
    for (int i = 0; i < data.length; i ++) {

      String dt[] = data[i].split(separateur);
      for (int j = 0; j  < dt.length; j ++) {
        if (dt[j].equals(none)) {
          dt[j] = elmNeutre;
        }
      }
      //int numero = int(dt[0]);
      String prenom = dt[1];
      String nom = dt[2];
      String naissance = dt[3];

      int t1 = 9+prenom.length();
      int t2 = 6+nom.length();
      int t3 = 12+naissance.length();
      int ttext = max(t1, t2, t3);

      int nLiens = dt.length-6;
      int liens[] = new int[nLiens];
      if (nLiens > 0) {
        for (int j = 6; j < dt.length; j ++) {
          liens[j-6] = int(dt[j]);
        }
      }


      profil[i] = new profils(float(dt[4]), float(dt[5]), prenom, nom, naissance, i, ttext, liens);
    }
  }
}


float mx(float x) {
  if (etat == 0) {
    return (x-xCam)/zoom;
  } else {
    return x;
  }
}


float my(float y) {
  if (etat == 0) {
    return (y-yCam)/zoom;
  } else {
    return y;
  }
}


void saveProfils() {
  String donneeP[] = new String[profil.length];
  for (int i = 0; i < profil.length; i ++) {

    donneeP[i] = str(i)+separateur+profil[i].prenomP+separateur+profil[i].nomP+separateur+profil[i].naissanceP+separateur+str(int(profil[i].xP))+separateur+str(int(profil[i].yP));
    int liens[] = profil[i].liensP;
    if (liens.length > 0) {
      donneeP[i] += separateur;
      for (int j = 0; j < liens.length; j ++) {
        donneeP[i] += str(liens[j]);
        if (j != liens.length-1) {
          donneeP[i] += separateur;
        }
      }
    }
  }
  saveStrings("donnee.txt", donneeP);
}


float x700(float xr700) {
  return xr700*width/700.0;
}

float y700(float yr700) {
  return yr700*height/700.0;
}
