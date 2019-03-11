

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    bombs = new ArrayList<MSButton>();
    //your code to initialize buttons goes here
     buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int i = 0;i<NUM_ROWS;i++)
        for(int n = 0;n<NUM_COLS;n++)
            buttons[i][n]=new MSButton(i,n);
    for(int i = 0; i<(int)((Math.random()*175)+25);i++)
    setBombs();
}
public void setBombs()
{
    //your code
     int rng1 = (int)(Math.random()*20);
     int rng2 = (int)(Math.random()*20);
    if(!bombs.contains(buttons[rng1][rng2]))
        bombs.add(buttons[rng1][rng2]);
    //rng1 = (int)(Math.random()*20);
    //rng2 = (int)(Math.random()*20);
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    int total=0;
    for(int i=0; i<bombs.size();i++)
        if(bombs.get(i).isMarked())
            total++;
    if(total==bombs.size())
        return true;
    return false;
}
public void displayLosingMessage()
{
    //your code here
    for(int i=0;i<NUM_ROWS;i++)
        for(int n=0;n<NUM_COLS;n++)
            buttons[i][n].setLabel("You Lose!");
}
public void displayWinningMessage()
{
    for(int i=0;i<NUM_ROWS;i++)
        for(int n=0;n<NUM_COLS;n++)
            buttons[i][n].setLabel("You Win!");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
         height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton==RIGHT)
        {
            if(marked==false)
                marked = true;            
            else if(marked==true)
            marked = false;
            if(marked==false)
                clicked=false;
        }
        else if(bombs.contains(buttons[r][c]))
                displayLosingMessage();
        else if(countBombs(r,c)>0)
            buttons[r][c].setLabel(""+countBombs(r,c));
        else
        {
            if(isValid(r-1,c-1)&&buttons[r-1][c-1].isClicked()==false)
                {

                   buttons[r-1][c-1].mousePressed();
                }
                if(isValid(r-1,c)&&buttons[r-1][c].isClicked()==false)
                {

                   buttons[r-1][c].mousePressed();
                }
                if(isValid(r-1,c+1)&&buttons[r-1][c+1].isClicked()==false)
                {

                   buttons[r-1][c+1].mousePressed();
                }
                if(isValid(r,c-1)&&buttons[r][c-1].isClicked()==false)
                {

                   buttons[r][c-1].mousePressed();
                }
                if(isValid(r,c+1)&&buttons[r][c+1].isClicked()==false)
                {

                   buttons[r][c+1].mousePressed();
                }
                if(isValid(r+1,c-1)&&buttons[r+1][c-1].isClicked()==false)
                {

                   buttons[r+1][c-1].mousePressed();
                }
                if(isValid(r+1,c)&&buttons[r+1][c].isClicked()==false)
                {

                   buttons[r+1][c].mousePressed();
                }
                if(isValid(r+1,c+1)&&buttons[r+1][c+1].isClicked()==false)
                {

                   buttons[r+1][c+1].mousePressed();
                }
                buttons[r][c].mousePressed();
        }    
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
        if(isWon())
            displayWinningMessage();
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r<=NUM_ROWS && c<=NUM_COLS)
            return true;
        return false; 
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        for(int z=row-1;z<=row+1;z++)
            for(int x=col-1;x<=col+1;x++)
                if(isValid(z,x)==true&&bombs.contains(buttons[z][x]))
                    numBombs++;
        return numBombs;
    }
}