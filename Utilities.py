# -*- coding: utf-8 -*-
"""
Joe Fordyce
Jimin Huh
Computational Thinking Spring 2021
Final Project
"""

import csv
import pandas as pd
from tkinter import *
import matplotlib.pyplot as plt
import PIL.Image
import PIL.ImageTk


def loadData(self,driver):
    '''
    Loads the given driver's race data
    Parameters: driver : String
    Returns: averages : Dictionary 
    '''
    df = ''
    if(driver == 'lewis'):
        df = pd.read_csv('LewisTest.csv')
    else:
        df = pd.read_csv('MaxTest.csv')
    df.loc['Average'] = df.mean(skipna=True)
    averages = {}
    for col in range(len(df.columns)):
        name = list(df.columns)[col]
        race_avg = df.at['Average', name]
        if('Unnamed' not in name):
            averages[name.lower()] = race_avg
    return averages

def getDriverData(self):
    '''Stores race data in self'''
    self.lewis_averages = loadData(self,'lewis')
    self.max_averages = loadData(self,'max')
    
def getRaceTime(self):
    '''
    Retrieves specified lap time for given track
    Returns: Average lap time in minutes
    '''
    current_driver = self.t2.get() 
    driver_times = {}
    if(current_driver == 'lewis.jpg'):
        driver_times = self.lewis_averages
    else:
        driver_times = self.max_averages
    
    current_race = self.t.get().replace('.png', '')
    if(current_race == 'greatbritain'):
        current_race = 'great britain'
    elif(current_race == 'abudhabi'):
        current_race = 'abu dhabi'
    elif(current_race == 'unitedstates'):
        current_race = 'united states'
        
    return round(driver_times[current_race],6)
    
def getTeamData(self):
    '''Loads and Stores pit data in self '''
    current_driver = self.t2.get()
    df = ''
    if(current_driver == 'Lewis.jpg'):
        df = pd.read_csv('LewisPit.csv')
    else:
        df = pd.read_csv('MaxPit.csv')

    df.loc['Average'] = df.mean(skipna=True)
    pit_times = {}
    
    for col in range(len(df.columns)):
        name1 = list(df.columns)[col]
        pit_avg = df.at['Average', name1]
        if('Unnamed' not in name1):
            pit_times[name1.lower()] = pit_avg
        
    if(current_driver == 'lewis.jpg'):
        self.lewis_pit = pit_times
    else:
        self.max_pit = pit_times

def getPitTime(self): 
    '''
    Retrieves specified pit time for given track
    Returns: Average pit time in seconds
    '''
    current_driver = self.t2.get() 
    pit_times = {}
    if(current_driver == 'lewis.jpg'):
        pit_times = self.lewis_pit
    else:
        pit_times = self.max_pit
    
    current_race = self.t.get().replace('.png', '')
    if(current_race == 'greatbritain'):
        current_race = 'great britain'
    elif(current_race == 'abudhabi'):
        current_race = 'abu dhabi'
    elif(current_race == 'unitedstates'):
        current_race = 'united states'
    
    return round(pit_times[current_race],6)
    
def getPerformances(self):
    '''
    Retrieves points and wins for specified grand prix since 2016
    Returns: Performance data : Dictionary
    '''
    df = pd.read_csv('Performances.csv', index_col=0)
    
    current_race = self.t.get().replace('.png', '').capitalize()
    current_driver = self.t2.get().replace('.jpg', '').capitalize()
    
    if(current_race == 'Greatbritain'):
        current_race = 'Great Britain'
    elif(current_race == 'Abudhabi'):
        current_race = 'Abu Dhabi'
    elif(current_race == 'Unitedstates'):
        current_race = 'United States'
        
    points = df.at[current_race, current_driver + ' Points']
    
    wins = df.at[current_race, current_driver + ' Wins']
       
    return {'points':points, 'wins':wins}
 
def constructGraph(self):
    ''' Constructs Matplotlib graph of Max versus Lewis'''
    getDriverData(self)

    lewisRace = self.lewis_averages.keys()
    raceTimeLewis = self.lewis_averages.values()

    maxRace = self.max_averages.keys()
    raceTimeMax = self.max_averages.values()
    fig = plt.figure()
    plt.plot(lewisRace, raceTimeLewis, label = 'lewis')
    plt.plot(maxRace, raceTimeMax, label = 'max')
    plt.legend()
    plt.xticks(rotation='vertical')
    plt.xlabel('Grand Prix')
    plt.ylabel('Time (minutes per lap)')
    plt.title('Max Versus Lewis')
    plt.tight_layout()
    mydpi = 122
    plt.savefig('maxvslewis.png', dpi=mydpi)
    
    self.listbox.insert(END, 'Loaded graph.png')
    self.fp = open('maxvslewis.png','rb')
    self.img = PIL.Image.open(self.fp)
    self.photo2 = PIL.ImageTk.PhotoImage(self.img)
    self.l3 = Label(image=self.photo2)
    self.l3.place(x=1100,y=400)
  