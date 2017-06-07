//*********************************
void mousePressed()
//*********************************
{
  x2 = mouseX;
  y2 = mouseY;
  x1 = pmouseX;
  y1 = pmouseY;

  if (mouseButton == LEFT)
  {
    // WEB PRESSED
    if ((!keyPressed) && (tool=="Web") && (!eraseW) && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      if (grab) { grabLayer(); } // grab layer for Undo
      livelli[activeLyr].pg.beginDraw(); // open active layer PGraphics
      livelli[activeLyr].pg.noFill();
      livelli[activeLyr].pg.stroke(brushCol);
      livelli[activeLyr].pg.strokeWeight(brushSize);
      if (noGlitch) { prepareGlitch(); } // Start antialias...
      attractionW = slWEBA.v;
      densityW = slWEBD.v/100.0;
      typeW = (int) sbWEBT.v;
      jitterW = (int) sbWEBJ.v;
      livelli[activeLyr].pg.endDraw(); // close active layer PGraphics
    }

    // WEB ERASE PRESSED
    else if ((!keyPressed) && (tool=="Web") && (eraseW) && ((!menu) || (x1 > menuX)))
    {
      for (int p=cobweb.size()-1; p >= 0 ; p--) // erase point from cobweb
      {
        PVector v = cobweb.get(p);
        if ((v.x > x2-brushSize/2) && (v.x < x2+brushSize/2) && (v.y > y2-brushSize/2) && (v.y < y2+brushSize/2))
        {
          if ((!aSelection) || (aSelection && v.x>x1sel && v.x<x2sel+1 && v.y>y1sel && v.y<y2sel+1)) // check active selection
          {
            cobweb.remove(p);
          }
        }
      }
    }

    // CONFETTI PRESSED
    else if ((!keyPressed) && (tool=="Confetti") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      if (grab) { grabLayer(); } // grab layer for Undo
      livelli[activeLyr].pg.beginDraw(); // open active layer PGraphics
      livelli[activeLyr].pg.noStroke();
      livelli[activeLyr].pg.fill(brushCol);
      if (noGlitch) { prepareGlitch(); } // Start antialias...
      // reset Confetti arrayList
      confettiThings.clear();
      livelli[activeLyr].pg.endDraw(); // close active layer PGraphics
    }

    // DYNA PRESSED
    else if ((!keyPressed) && (tool=="Dyna") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      if (grab) { grabLayer(); } // grab layer for Undo
      livelli[activeLyr].pg.beginDraw(); // open active layer PGraphics
      livelli[activeLyr].pg.noStroke();
      livelli[activeLyr].pg.fill(brushCol);
      if (noGlitch) { prepareGlitch(); } // Start antialias...
      // reset Dyna parameters
      myDD.px = mouseX;
      myDD.py = mouseY;
      myDD.ppx = mouseX;
      myDD.ppy = mouseY;
      myDD.vx = 0;
      myDD.vy = 0;
      myDD.old_brush = myDD.min_brush;
      livelli[activeLyr].pg.endDraw(); // close active layer PGraphics
    }

    // LINER PRESSED
    else if ((!keyPressed) && (tool=="Liner") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      lineDown = true;
      x1L = x2;   y1L = y2;
      x2L = x1L;  y2L = y1L;
    }

    // QUAD PRESSED
    else if ((!keyPressed) && (tool=="Quad") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      quadDown = true;
      x1L = x2;   y1L = y2;
      x2L = x1L;  y2L = y1L;
    }

    // CIRCLED PRESSED
    else if ((!keyPressed) && (tool=="Circle") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      circleDown = true;
      x1L = x2;  y1L = y2;
      x2L = x1L;  y2L = y1L;
    }

    // SELECTION PRESSED
    else if ((!keyPressed) && (tool=="Select") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      selectDown = true;
      aSelection = false;
      x1L = x2;  y1L = y2;
      x2L = x1L;  y2L = y1L;
    }

    // PENCIL PRESSED
    else if ((!keyPressed) && (tool=="Pencil") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      if (grab) { grabLayer(); } // grab layer for Undo
      livelli[activeLyr].pg.beginDraw(); // open active layer PGraphics
      if (noGlitch) { prepareGlitch(); } // Start antialias...
      livelli[activeLyr].pg.noStroke();
      livelli[activeLyr].pg.fill(brushCol);
      if (aSelection) { livelli[activeLyr].pg.clip(x1sel+1, y1sel+1, x2sel-x1sel-1, y2sel-y1sel-1); } // check selection
      drawLine(x1,y1,x2,y2, brushSize, livelli[activeLyr].pg); // draw on active layer
      if (symX) // draw symmetry from X axis
      {
        calcSymX(x1,y1,x2,y2);
        drawLine(s1x, s1y, s2x, s2y, brushSize, livelli[activeLyr].pg);
      }
      if (symY) // draw symmetry from Y axis
      {
        calcSymY(x1,y1,x2,y2);
        drawLine(s1x, s1y, s2x, s2y, brushSize, livelli[activeLyr].pg);
      }
      if(symX && symY) // draw symmetry from center point (opposite)
      {
        calcSymXY(x1,y1,x2,y2);
        drawLine(s1x, s1y, s2x, s2y, brushSize, livelli[activeLyr].pg);
      }
      livelli[activeLyr].pg.endDraw(); // close active layer PGraphics
    }

    // SHAPE PRESSED
    else if ((!keyPressed) && (tool=="Shape") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      if (grab) { grabLayer(); } // grab layer for Undo
      livelli[activeLyr].pg.beginDraw(); // open active layer PGraphics
      if (noGlitch) { prepareGlitch(); } // Start antialias...
      livelli[activeLyr].pg.stroke(brushCol);
      livelli[activeLyr].pg.noFill();
      if (aSelection) { livelli[activeLyr].pg.clip(x1sel+1, y1sel+1, x2sel-x1sel-1, y2sel-y1sel-1); } // check selection

      color shColor;
      int numItems = (int) slSHitems.v;
      livelli[activeLyr].pg.rectMode(CENTER);
      livelli[activeLyr].pg.shapeMode(CENTER);
      for (int i = 0; i < numItems; i++)
      {
        int posX = x2 + (int) (round(random(-slSHposD.v, +slSHposD.v)));
        int posY = y2 + (int) (round(random(-slSHposD.v, +slSHposD.v)));
        int bSizeH = brushSize + (int) (round(random(-slSHsizeD.v, +slSHsizeD.v)));
        int bSizeV = brushSize + (int) (round(random(-slSHsizeD.v, +slSHsizeD.v)));
        int bAlfa = alfa + (int) (round(random(-slSHalfaD.v, +slSHalfaD.v)));
        if (cbSHcolorRND.s)
        {
          shColor = randomColor();
          shColor = color((shColor >> 16) & 0xFF, (shColor >> 8)  & 0xFF, shColor & 0xFF, bAlfa);
        }
        else
        {
          shColor = color((brushCol >> 16) & 0xFF, (brushCol >> 8)  & 0xFF, brushCol & 0xFF, bAlfa);
        }
        livelli[activeLyr].pg.stroke(shColor);
        // draw on active layer
        switch((int)sbSHtype.v)
        {
          case 1: // rectangle
            livelli[activeLyr].pg.rect(posX, posY, bSizeH, bSizeV);
            if (symX)
            {
              calcSymX(posX, posY, posX, posY);
              livelli[activeLyr].pg.rect(s1x, s1y, bSizeH, bSizeV);
            }
            if (symY) // draw symmetry from Y axis
            {
              calcSymY(posX, posY, posX, posY);
              livelli[activeLyr].pg.rect(s1x, s1y, bSizeH, bSizeV);
            }
            if(symX && symY) // draw symmetry from center point (opposite)
            {
              calcSymXY(posX, posY, posX, posY);
              livelli[activeLyr].pg.rect(s1x, s1y, bSizeH, bSizeV);
            }
            break;
          case 2: // square
            livelli[activeLyr].pg.rect(posX, posY, bSizeH, bSizeH);
            if (symX)
            {
              calcSymX(posX, posY, posX, posY);
              livelli[activeLyr].pg.rect(s1x, s1y, bSizeH, bSizeH);
            }
            if (symY) // draw symmetry from Y axis
            {
              calcSymY(posX, posY, posX, posY);
              livelli[activeLyr].pg.rect(s1x, s1y, bSizeH, bSizeH);
            }
            if(symX && symY) // draw symmetry from center point (opposite)
            {
              calcSymXY(posX, posY, posX, posY);
              livelli[activeLyr].pg.rect(s1x, s1y, bSizeH, bSizeH);
            }
            break;
          case 3: // ellipse
            livelli[activeLyr].pg.ellipse(posX, posY, bSizeH, bSizeV);
            if (symX)
            {
              calcSymX(posX, posY, posX, posY);
              livelli[activeLyr].pg.ellipse(s1x, s1y, bSizeH, bSizeV);
            }
            if (symY) // draw symmetry from Y axis
            {
              calcSymY(posX, posY, posX, posY);
              livelli[activeLyr].pg.ellipse(s1x, s1y, bSizeH, bSizeV);
            }
            if(symX && symY) // draw symmetry from center point (opposite)
            {
              calcSymXY(posX, posY, posX, posY);
              livelli[activeLyr].pg.ellipse(s1x, s1y, bSizeH, bSizeV);
            }
            break;
          case 4: // circle
            livelli[activeLyr].pg.ellipse(posX, posY, bSizeV, bSizeV);
            if (symX)
            {
              calcSymX(posX, posY, posX, posY);
              livelli[activeLyr].pg.ellipse(s1x, s1y, bSizeV, bSizeV);
            }
            if (symY) // draw symmetry from Y axis
            {
              calcSymY(posX, posY, posX, posY);
              livelli[activeLyr].pg.ellipse(s1x, s1y, bSizeV, bSizeV);
            }
            if(symX && symY) // draw symmetry from center point (opposite)
            {
              calcSymXY(posX, posY, posX, posY);
              livelli[activeLyr].pg.ellipse(s1x, s1y, bSizeV, bSizeV);
            }
            break;
          case 5: // user svg
            int dimX = (int) aShape.width*bSizeH/brushSizeMax;
            int dimY = (int) aShape.height*bSizeH/brushSizeMax;
            livelli[activeLyr].pg.shape(aShape, posX, posY, dimX, dimY);
            break;
        } //end switch
      }

      livelli[activeLyr].pg.rectMode(CORNER);
      livelli[activeLyr].pg.shapeMode(CORNER);
      livelli[activeLyr].pg.endDraw(); // close active layer PGraphics
    }

    // ERASER PRESSED
    else if ((!keyPressed) && (tool=="Eraser") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      if (grab) { grabLayer(); }  // grab layer for Undo
      livelli[activeLyr].pg.beginDraw(); // open active layer PGraphics
      if (noGlitch) { prepareGlitch(); } // Start antialias...
      livelli[activeLyr].pg.noStroke();
      livelli[activeLyr].pg.fill(0,0,0,0);
      livelli[activeLyr].pg.blendMode(REPLACE);
      if (aSelection) { livelli[activeLyr].pg.clip(x1sel+1, y1sel+1, x2sel-x1sel-1, y2sel-y1sel-1); } // check selection
      drawLine(x1,y1,x2,y2, brushSize, livelli[activeLyr].pg); // draw/erase on active layer
      if (symX) // draw symmetry from X axis
      {
        calcSymX(x1,y1,x2,y2);
        drawLine(s1x,s1y,s2x,s2y, brushSize, livelli[activeLyr].pg);
      }
      if (symY) // draw symmetry from Y axis
      {
        calcSymY(x1,y1,x2,y2);
        drawLine(s1x,s1y,s2x,s2y, brushSize, livelli[activeLyr].pg);
      }
      if(symX && symY) // draw symmetry from center point (opposite)
      {
        calcSymXY(x1,y1,x2,y2);
        drawLine(s1x,s1y,s2x,s2y, brushSize, livelli[activeLyr].pg);
      }
      livelli[activeLyr].pg.endDraw(); // close active layer PGraphics
    }

    // VERNICE PRESSED
    else if ((!keyPressed) && (tool=="Vernice" || tool == "Stencil") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      int x0 = mouseX;
      int y0 = mouseY;
      if (grab) { grabLayer(); } // grab layer for Undo
      livelli[activeLyr].pg.beginDraw(); // open active layer PGraphics
      // if (noGlitch) { prepareGlitch(); } // No antialias with this tool :-)
      livelli[activeLyr].pg.loadPixels();
      drawLinePIXEL(x1,y1,x2,y2, brushSize, livelli[activeLyr].pg);
      if (symX) // draw symmetry from X axis
      {
        calcSymX(x1,y1,x2,y2);
        drawLinePIXEL(s1x, s1y, s2x, s2y, brushSize, livelli[activeLyr].pg);
      }
      if (symY) // draw symmetry from Y axis
      {
        calcSymY(x1,y1,x2,y2);
        drawLinePIXEL(s1x, s1y, s2x, s2y, brushSize, livelli[activeLyr].pg);
      }
      if(symX && symY) // draw symmetry from center point (opposite)
      {
        calcSymXY(x1,y1,x2,y2);
        drawLinePIXEL(s1x, s1y, s2x, s2y, brushSize, livelli[activeLyr].pg);
      }
      livelli[activeLyr].pg.endDraw(); // close active layer PGraphics
      livelli[activeLyr].pg.updatePixels();
      livelli[activeLyr].pg.endDraw(); // close active layer PGraphics
    }

    // INK PRESSED
    else if ((!keyPressed) && (tool=="Ink") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      int x0 = mouseX;
      int y0 = mouseY;
      if (grab) { grabLayer(); } // grab layer for Undo
      //livelli[activeLyr].pg.noSmooth();
      livelli[activeLyr].pg.beginDraw(); // open active layer PGraphics
      livelli[activeLyr].pg.noStroke();
      livelli[activeLyr].pg.fill(brushCol);
      if (noGlitch) { prepareGlitch(); } // Start antialias...
      if (aSelection) { livelli[activeLyr].pg.clip(x1sel+1, y1sel+1, x2sel-x1sel-1, y2sel-y1sel-1); } // check selection
      myIB.clear();
      myIB.clearPolys();
      myIB.addPoint(x0, y0);
      livelli[activeLyr].pg.endDraw(); // close active layer PGraphics
    }

    // STAMP PRESSED
    else if ((!keyPressed) && (tool=="Stamp") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      xs0 = mouseX;
      ys0 = mouseY;
      if (grab) { grabLayer(); } // grab layer for Undo
      livelli[activeLyr].pg.beginDraw(); // open active layer PGraphics
      if (noGlitch) { prepareGlitch(); } // Start antialias...
      if (!userStamp) { mySB.createStampBrush(); }
      if (aSelection) { livelli[activeLyr].pg.clip(x1sel+1, y1sel+1, x2sel-x1sel-1, y2sel-y1sel-1); } // check selection
      livelli[activeLyr].pg.image(stampPG, xs0-brushSize/2,ys0-brushSize/2);
      livelli[activeLyr].pg.endDraw(); // close active layer PGraphics
    }

    // MIXER PRESSED
    else if ((!keyPressed) && (tool=="Mixer") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      xs0 = mouseX;
      ys0 = mouseY;
      if (grab) { grabLayer(); } // grab layer for Undo
      livelli[activeLyr].pg.beginDraw(); // open active layer PGraphics
      // create mixer brush
      mixer_alpha = (int)slMIXERA.v;
      mixer_decay = (int)slMIXERD.v;
      mixer = livelli[activeLyr].pg.get(xs0-brushSize/2,ys0-brushSize/2,brushSize,brushSize);
      if (noGlitch) { prepareGlitch(); } // Start antialias...
      // create mixer brush
      mixer.loadPixels();
      int cx = mixer.width/2;
      int cy = mixer.height/2;
      int loc = 0;
      for (int x = 0; x < brushSize; x++)
      {
        for (int y = 0; y < brushSize; y++)
        {
          if (dist(x,y,cx,cy) >= brushSize/2)
          {
            loc = x + y * mixer.width;
            mixer.pixels[loc] = 0x0;
          }
        }
      }
      mixer.updatePixels();
      livelli[activeLyr].pg.endDraw(); // close active layer PGraphics
    }

    // FILLER PRESSED
    else if ((!keyPressed) && (tool=="Filler") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      if (!cbFILLERASE.s) // fill area
      {
        // do not fill if same colors
        if (brushCol != livelli[activeLyr].pg.get(mouseX,mouseY))
        {
          startAction = true;
          if (grab) { grabLayer(); }  // grab layer for Undo
          // Flood fill area of active layer with current color
          floodFill(livelli[activeLyr].pg, mouseX, mouseY, brushCol);
          mousePressed = false;
        }
        else { println("no fill: SAME COLORS"); }
      }
      else // erase area
      {
          if (((livelli[activeLyr].pg.get(mouseX,mouseY) >> 24) & 0xff ) != 0) // not transparent
          {
            startAction = true;
            if (grab) { grabLayer(); }  // grab layer for Undo
            // Flood fill area of active layer with current color
            floodFill(livelli[activeLyr].pg, mouseX, mouseY, 0x0);
            mousePressed = false;
          }
          else { println("no erase: ALREADY ERASED"); }
      }
    }

    // CLONE PRESSED (LEFT BUTTON)
    else if ((!keyPressed) && (tool=="Clone") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      x2 = mouseX;
      y2 = mouseY;
      if (cloneGap)
      {
        gapX = x2 - cloneX;
        gapY = y2 - cloneY;
        cloneGap = true;
      }
      if (grab) { grabLayer(); } // grab layer for Undo
    }

    // ALPHA PRESSED
    else if ((!keyPressed) && (tool=="Alpha") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      int x0 = mouseX;
      int y0 = mouseY;
      if (grab) { grabLayer(); } // grab layer for Undo
      livelli[activeLyr].pg.beginDraw(); // open active layer PGraphics
      // Clear string hashset (Set<String> pts = new HashSet<String>();)
      if (!cbALPHAT.s) { pts.clear(); }
      int numPtrs = pts.size();
      int ll = width*height;
      int dAlpha = (int) slALPHAT.v;
      livelli[activeLyr].pg.loadPixels();
      int rr = brushSize/2;
      for (int x = x0 - rr; x < x0 + rr; x++)
      {
        for (int y = y0 - rr; y < y0 + rr; y++)
        {
          int loc = x+y*width;
          String newPt = String.valueOf(loc);
          if (pts.contains(newPt))
          { } // do nothing (the point is already processed)
          else
          {
            if ((!aSelection) || (aSelection && x>x1sel && x<x2sel && y>y1sel && y<y2sel)) // check active selection
            {
              if ((loc >= 0) && (loc < ll) && ((x - x0)*(x - x0) + (y - y0)*(y - y0) < rr*rr))
              {
                // add new point to hashset
                pts.add(newPt);
                // process point
                color tc = livelli[activeLyr].pg.pixels[loc];
                int ta = (tc >> 24) & 0xff;
                ta = constrain(ta + dAlpha,1,255);
                tc = color((tc >> 16) & 0xFF, (tc >> 8)  & 0xFF, tc & 0xFF, ta);
                livelli[activeLyr].pg.pixels[loc] = tc;
              }
            }
          }
        }
      }
      livelli[activeLyr].pg.updatePixels();
      livelli[activeLyr].pg.endDraw(); // close active layer PGraphics
    }

    // TOOL01 PRESSED
    else if ((!keyPressed) && (tool=="Tool01") && (!livelli[activeLyr].ll) && ((!menu) || (x1 > menuX)))
    {
      startAction = true;
      int x0 = mouseX;
      int y0 = mouseY;
      if (grab) { grabLayer(); } // grab layer for Undo
      livelli[activeLyr].pg.beginDraw(); // open active layer PGraphics
      // Clear string hashset (Set<String> pts = new HashSet<String>();)
      pts.clear();
      int numPtrs = pts.size();
      int ll = width*height;
      livelli[activeLyr].pg.loadPixels();
      int rr = brushSize/2;
      for (int x = x0 - rr; x < x0 + rr; x++)
      {
        for (int y = y0 - rr; y < y0 + rr; y++)
        {
          int loc = x+y*width;
          String newPt = String.valueOf(loc);
          if (pts.contains(newPt))
          { } // do nothing (the point is already processed)
          else
          {
            //if ((loc <= ll) && (round(dist(x, y, x0, y0)) < round(brushSize/2.0)))
            if ((loc >= 0) && (loc < ll) && ((x - x0)*(x - x0) + (y - y0)*(y - y0) < rr*rr))
            {
              // add new point to hashset
              pts.add(newPt);
              // process point
              color tc = livelli[activeLyr].pg.pixels[loc];
              int ta = (tc >> 24) & 0xff;
              ta = constrain(ta-10,1,255);
              tc = color((tc >> 16) & 0xFF, (tc >> 8)  & 0xFF, tc & 0xFF, ta);
              livelli[activeLyr].pg.pixels[loc] = tc;
            }
          }
        }
      }
      livelli[activeLyr].pg.updatePixels();
      livelli[activeLyr].pg.endDraw(); // close active layer PGraphics
    }

  } // LEFT mouse if

  else if (mouseButton == RIGHT)
  {
    // CLONE PRESSED (RIGHT BUTTON)
    if ((!keyPressed) && (tool=="Clone") && (!livelli[activeLyr].ll) && !myHSB.isOver() && ((!menu) || (x1 > menuX)))
    {
      cloneX = mouseX;
      cloneY = mouseY;
      cloneGap = true;
      gapX = mouseX - cloneX;
      gapY = mouseY - cloneY;
    }
    // STAMP PRESSED (RIGHT BUTTON) (userStamp)
    else if ((!keyPressed) && (tool=="Stamp") && (!livelli[activeLyr].ll) && !myHSB.isOver() && ((!menu) || (x1 > menuX)))
    {
      xs0 = mouseX;
      ys0 = mouseY;
      userStamp = true;
      int locLyr, locStamp;
      int locLyrMax = width*height;
      int locStampMax = brushSize*brushSize;
      stampPG = createGraphics(brushSize, brushSize);
      stampPG.noSmooth();
      stampPG.beginDraw();
      stampPG.clear();
      stampPG.loadPixels();
      livelli[activeLyr].pg.loadPixels();

      // clone image under cursor on stampPG
      for (int y = ys0-brushSize/2; y < ys0+brushSize/2; y++)
      {
        for (int x = xs0-brushSize/2; x < xs0+brushSize/2; x++)
        {
          locLyr = x + y*width;
          locStamp = (x - (xs0-brushSize/2)) + (y- (ys0-brushSize/2))*brushSize;
          if (locLyr > 0 && locLyr < locLyrMax && locStamp > 0 && locStamp < locStampMax)
          {
            if (livelli[activeLyr].pg.pixels[locLyr] != 0x0)
            {
              { stampPG.pixels[locStamp] = livelli[activeLyr].pg.pixels[locLyr]; }
            }
          }
        }
      }
      //livelli[activeLyr].pg.updatePixels();
      stampPG.updatePixels();
      stampPG.endDraw();
    }
  } // RIGHT mouse if

  // PICK COLOR PRESSED
  if (keyPressed && mousePressed && picker && !myHSB.isOver()) // pick color from active layer
  {
    color pickCol;
    if (mouseButton == RIGHT)
    {
     pickCol = livelli[activeLyr].pg.get(mouseX,mouseY);
    }
    else
    {
      pickCol = get(mouseX,mouseY);
    }
    brushCol = color(pickCol,alfa);
    rgbhsb.setRGBHSB(brushCol);
    myHSB.updateHSB("HSB");
    picker = false;
  }

  // MENU PRESSED
  if (menu)
  {
    // check layer icons pressed
    for(int i = 0; i < livelli.length; i++)
    {
      livelli[i].onClickIcon();
      livelli[i].onClickTransp();
    }
    controlloLivelli.onClick();
    // check pressed on RGB-SHB control
    rgbhsb.onClick();
    // check on palette page pressed
    tavolozza.onClick();
    // check button tools
    btnPENCIL.onClick();
    btnLINER.onClick();
    btnLOCK.onClick();
    btnQUAD.onClick();
    btnCIRCLE.onClick();
    btnERASER.onClick();
    btnSELECT.onClick();
    btnSTENCIL.onClick();
    btnVERNICE.onClick();
    btnINK.onClick();
    btnSTAMP.onClick();
    btnMIXER.onClick();
    btnDYNA.onClick();
    btnFILLER.onClick();
    btnCLONE.onClick();
    btnWEB.onClick();
    btnCONFETTI.onClick();
    btnSHAPE.onClick();
    btGRID.onClick();
    // open & save
    btOPENLYR.onClick();
    btOPEN.onClick();
    btSAVE.onClick();
    // undo/redo
    btnUNDO.onClick();
    btnREDO.onClick();
    // check Brush size slider
    slSIZE.onClick();
    // check Alfa slider
    slALFA.onClick();
    // check X,Y symmetry checkbox
    cbSYMX.onClick();
    cbSYMY.onClick();
    // check no Glitch checkbox
    cbGLITCH.onClick();
    // check grid checkbox
    sbGRIDX.onClick();
    sbGRIDY.onClick();
    cbGRID.onClick();
    cbSNAP.onClick();

    // new tools
    btnALPHA.onClick();
    btnTool01.onClick();

    // check Alpha options
    if (tool == "Alpha")
    {
      slALPHAT.onClick();
      cbALPHAT.onClick();
    }

    // check Filler options
    else if (tool == "Filler")
    {
      slFILLER.onClick();
      cbFILLERASE.onClick();
    }
    // check Clone options
    else if (tool == "Clone")
    {
      cbCLONE.onClick();
    }
    // check Mixer options
    else if (tool == "Mixer")
    {
      slMIXERA.onClick();
      slMIXERD.onClick();
    }
    // check Stamp options
    else if (tool == "Stamp")
    {
      mySB.onClick();
      slSTAMP.onClick();
      slSTAMP2.onClick();
    }
    // check Web options
    else if (tool == "Web")
    {
      slWEBA.onClick();
      slWEBD.onClick();
      btWEB.onClick();
      sbWEBT.onClick();
      sbWEBJ.onClick();
      cbWEBE.onClick();
      cbWEBP.onClick();
    }
    // check dyna options
    else if (tool == "Dyna")
    {
      dslHOOKE.onClick();
      dslDAMPING.onClick();
      dslDUCTUS.onClick();
      dslMASS.onClick();
      dslMINB.onClick();
      dslMAXB.onClick();
      btnPRE01.onClick();
      btnPRE02.onClick();
      btnPRE03.onClick();
      btnPRE04.onClick();
      btnPRE05.onClick();
      btnPRE06.onClick();
      btnPRE07.onClick();
      btnPRE08.onClick();
    }
    // check Select options
    else if (tool == "Select")
    {
      cbSELECT.onClick();
      cbSELOUT.onClick();
      btSELCOPY.onClick();
      btSELPASTE.onClick();
      btSELDRAW.onClick();
      btSELSAVE.onClick();
    }
    // check Stencil options
    else if (tool == "Stencil")
    {
      cbSTENCIL.onClick();
      btSTENLOAD.onClick();
      btSTENCENTER.onClick();
      btSTENCREA.onClick();
      btSTENINVERT.onClick();
    }
    // check Confetti Options
    else if (tool == "Confetti")
    {
      cbCONFSCALE.onClick();
      cbCONFRND.onClick();
      slCONFVEL.onClick();
      slCONFDVEL.onClick();
    }
    // check Shape Options
    else if (tool == "Shape")
    {
      slSHitems.onClick();
      slSHsizeD.onClick();
      slSHalfaD.onClick();
      slSHposD.onClick();
      cbSHcolorRND.onClick();
      cbSHstyle.onClick();
      sbSHtype.onClick();
      btSHSVG.onClick();
    }

    // check background button
    btcBACKCOL.onClick();
  }

  // HSB pressed
  if (toolHSB)
  {
    myHSB.onClick();
  }
}