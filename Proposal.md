## Proposal

### 1.	Overview
Security is a vital indicator of an area'Äôs living situation, it has been taken seriously while people talk about their neighborhood or hometown. But when people talked about security, few of them are using data to get a solid evidence to back up their stories, most of them usually talk about this topic by experience or feelings. Thanks to Marshall project, we now have the data of crime number through 68 US cities from 1975 to 2015. In order to give the people a vision of security situation they have been, we would build an app to display different aspect of crime cases. Our app will allow users to browse crime data of the place they cared about, hence, showing them the security situation in the area.

### 2.	Data Description
We have around 2800 records from 68 US cities' police department, each one of them contains the crime data of one city from a specific year.  Among 17 variables of the data, we will focus on following 9 variables in order to give users more targeting experience: ORI(unique identifier), year, department_name  (city name), total_pop (population of the city), violent_per_100k, homs_per_100k, rape_per_100k, rob_per_100k, agg_ass_per_100k. By analyzing ORI and department_name, we are replacing these 2 variables with 2 new ones: State and City, to give the users a better browse experience.

### 3.	Usage scenario & task
We are currently working on developing several user scenarios:
#### a)	Time - location scenarios
Jack has lived in Chicago since he was born, recently he has been relocated to Atlanta due to employment. He has never been to Atlanta before and want to be prepared ahead.  One of the important aspects is the city's safety situation. When he logs into "Crime Data Browser"Äù (name TBD), he could select through dropdown menu in column "location"Äù, he select "GA", "ÄúAtlanta"Äù, then the five type of crimes data (homicide, rape, robbery, violent crime, aggressive assault) will be displayed using case amount per 10k people as indicator along with total population of each year. Five charts listed from top to bottom would be clear to comparison.  From here, Jack could also be able to select a specific year or crime type to go deeper. All these information would help Jack has a better understanding of security situation in Atlanta.

#### b)	Location ‚Äì time scenarios
Mary is a researcher who is doing a project about police department performance. When she logged into "Crime Data Browser"Äù(name TBD), she could select through dropdown menu in column "Year"Äù, after she choosing a specific year, crime data of 68 cities will displayed in 5 bar charts respect to different crime types using case amount per 10k people as indicator along with total population of that year. She can rank the data from lowest to highest crime rate to see which cities has the better police works. From there, she could select more specifically through "State"Äù to see the data within a State.

### 4.	App Description & initial sketch
 The app has a landing page that display 68 locations which this app contains.  On the left side of the interface, there are two options let the user choose if they need Time ‚Äì location scenario or Location ‚Äì time scenario. After choosing the scenario, the app displaying corresponding dropdown menu filters to let the user move forward. For example, if the user choose Time ‚Äì location, the dropdown menu filter will became available in the order of "Year", "State"Äù, "City". As the user doing the filtering, the chart area will change with related chart.
