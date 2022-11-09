'''
Joe Fordyce
Jimin Huh
Computational Thinking Spring 2021
Final Project
'''

import PIL.Image 
import PIL.ImageTk
from tkinter import * 
from Utilities import *



class AllTkinterWidgets:
      def __init__(self, master):
          self.lewis_averages = {}
          self.max_averages = {}
          self.lewis_pit = {}
          self.max_pit = {}
          self.canvas = Canvas(master, width = root.winfo_screenwidth(), height = root.winfo_screenheight(), bd = 2)
          self.canvas.pack(expand = 0)
          self.canvas.configure(background = 'black')
          
       # -------------------- Main GUI Frame ------------------------
          self.mbar = Frame(self.canvas, relief = 'raised', width=500, bd = 2)
          self.mbar.place(height = 300, width = 400)        
          
          
       #--------------------- Historical Statistic Display Area Creation-------------------
          self.canvas2 = Canvas(master, width = 500, height = 200)
          self.canvas2.place(x=550, y=400)
          self.canvas2.configure(background = 'grey')
          self.canvas2.create_text(50,40, text = 'Historical Average Lap Time: ', fill = 'black', font = 'Helvetica 15 bold', anchor = NW)
          self.canvas2.create_text(50,80, text = "Historical Average Pit Time: ", fill = 'black', font = 'Helvetica 15 bold', anchor = NW)
          self.canvas2.create_text(50,120, text = 'Points Since 2016: ', fill = 'black', font = 'Helvetica 15 bold', anchor = NW)
          self.canvas2.create_text(50,160, text = 'Wins Since 2016: ', fill = 'black', font = 'Helvetica 15 bold', anchor = NW)
          
       
       # ------------------- Race List Creation --------------------------------
          self.canvas3 = Canvas(master, width = 200, height = 400)
          self.canvas3.place(x=50, y=350)
          self.canvas3.configure(background = 'grey')
          self.canvas3.create_text(90,30, text = 'Possible Races:', fill = 'black', font = 'Helvetica 15 bold')
          self.canvas3.create_text(90,50, text = 'Australia', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,70, text = 'Monaco', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,90, text = 'Canada', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,110, text = 'Austria', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,130, text = 'Great Britain', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,150, text = 'Hungary', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,170, text = 'Belgium', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,190, text = 'Italy', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,210, text = 'Singapore', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,230, text = 'Japan', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,250, text = 'Russia', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,270, text = 'United States', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,290, text = 'Mexico', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,310, text = 'Brazil', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,330, text = 'Abu Dhabi', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,350, text = 'Azerbaijan', fill = 'black', font = 'Helvetica 12 bold')
          self.canvas3.create_text(90,370, text = 'France', fill = 'black', font = 'Helvetica 12 bold')
       
        # ------------------- Formula 1 Title Creation -----------
          self.text = Text(self.mbar, height = 5, width =52)
          self.l = Label(self.mbar, text = 'Formula 1')
          self.l.config(font=('Helvetica',12))
          self.l.pack(side = TOP)
         
          
       # -------------------- Entry Boxes for Driver and Race, Load Buttons, Label Placements ---------------------
          self.t = StringVar()
          self.t2 = StringVar()
          self.ef = Frame(self.canvas, bd=2, relief='groove')
          self.lb2 = Label(self.ef, text='Race:  ')
          self.lb2.pack(side= LEFT)
          self.entry = Entry(self.ef, textvariable = self.t, bg='white')
          self.bt = Button(self.ef, text = 'Load', command = self.load_race)
          self.entry.pack(side = LEFT, padx = 5)
          self.bt.pack(side = LEFT, padx= 5)
          self.ef.pack(expand=0, fill=X, pady=5, after = self.l, anchor = W)
       
          self.l1 = Label().place(x=550,y=0)
          self.l2 = Label().place(x=950,y=0)
          self.l3 = Label().place(x=1100,y=400)
          
          self.ef2 = Frame(self.canvas, bd=2, relief = 'groove')
         
          self.lb3 = Label(self.ef2, text='Driver:')
          self.lb3.pack(side=LEFT)
          self.entry2 = Entry(self.ef2,textvariable=self.t2, bg='white')
          
          self.bt3 = Button(self.ef2, text = 'Load', command = self.load_driver)
          self.entry2.pack(side=LEFT, padx=5)
          self.bt3.pack(side=LEFT, padx=5)
          self.ef2.pack(expand=0, fill=X, pady=5, after = self.l, anchor = W)
          

       # --------------------- Listbox frame, Clear Button and Display Graph Button------------------------
          self.lf = Frame(self.canvas, bd=2, relief='groove')
          self.lb = Label(self.lf, text='Log:')
          self.bt1 = Button(self.lf, text = 'Display Graph', command = lambda: constructGraph(self))
          self.bt2 = Button(self.lf, text = 'Clear', command = self.clear)
          self.listbox = Listbox(self.lf, height=4)
          self.sbl = Scrollbar(self.listbox, orient=VERTICAL, command= self.listbox.yview)
          self.listbox.configure(yscrollcommand=self.sbl.set)
          self.lb.pack(side=LEFT, padx=5)
          self.bt2.pack(side = BOTTOM)
          self.bt1.pack(side = BOTTOM)
          self.sbl.pack(side=RIGHT, fill=Y)
          self.listbox.pack(padx=5, fill = X)
          self.lf.pack(expand=0, fill=X, pady=5, after = self.ef, anchor = W)

       # -------------------- Function defs ------------------------
      def clear(self):
          '''Clears driver's photo, racetrack photo, and resets statistic display area'''
          self.updateTimes()
          self.listbox.delete(0, END)
          self.l1.destroy()
          self.l2.destroy()
          
      def updateTimes(self,LapTime='',PitTime='',Points='',Wins=''):
          '''Populates statistic display area'''
          self.canvas2.delete('all')
          self.canvas2.create_text(50,40, text = 'Historical Average Lap Time: '+LapTime, fill = 'black', font = 'Helvetica 15 bold', anchor = NW)
          self.canvas2.create_text(50,80, text = "Historical Average Pit Time: "+PitTime, fill = 'black', font = 'Helvetica 15 bold', anchor = NW)
          self.canvas2.create_text(50,120, text = 'Points Since 2016: '+Points, fill = 'black', font = 'Helvetica 15 bold', anchor = NW)
          self.canvas2.create_text(50,160, text = 'Wins Since 2016: '+Wins, fill = 'black', font = 'Helvetica 15 bold', anchor = NW)
          
      def load_driver(self):
          '''Loads driver image and loads race and pit data in the back end'''
          try:
              self.updateTimes()
              getDriverData(self)
              getTeamData(self)
              self.listbox.insert(END, 'Loaded driver ' + self.t2.get())
              self.fp = open(self.t2.get(),'rb')
              self.img = PIL.Image.open(self.fp)
              self.photo = PIL.ImageTk.PhotoImage(self.img)
              self.l1 = Label(image=self.photo)
              self.l1.place(x=550,y=0)
          except: 
              self.listbox.insert(END, 'Error loading driver ' + self.t2.get())
              
      def load_race(self):
          '''Loads race image and displays loaded data in statistics display area for given race'''
          try:
              self.updateTimes()
              performance = getPerformances(self)
              race = getRaceTime(self)
              pit = getPitTime(self)
              self.updateTimes(LapTime=str(race), Points=str(performance['points']), Wins=str(performance['wins']), PitTime=str(pit))
              self.listbox.insert(END, 'Loaded race ' + self.t.get())
              self.fp = open(self.t.get(),'rb')
              self.img = PIL.Image.open(self.fp)
              self.photo1 = PIL.ImageTk.PhotoImage(self.img)
              self.l2 = Label(image=self.photo1)
              self.l2.place(x=950,y=0)
          except: 
              self.listbox.insert(END, 'Error loading race ' + self.t.get())

# main--setup tkinter object, instantiate AllTkinterWidgets class and display
root = Tk()
all = AllTkinterWidgets(root)
root.title('ProjectFordyceHuh') 
root.mainloop()






