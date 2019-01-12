## Project Milestone 1: Proposal
#### 1.	Overview

Security is a key factor in choice of the city you want to live in, but when people talk about security, only a few of them rely on solid data to support their arguments. Thanks to Marshall project, we now have access to the crime data of 68 US cities from 1975 to 2015. In order to help people to understand this data base better, we are going to build an app to visualize the different aspects of the data. Our app will allow users to browse the crime data of a certain city and compare it with other cities and predict the crime rate in the future based on the historical data available to them.
#### 2.	Data Description

We have around 2800 records from 68 US cities’ police department, each one of them contains the crime data of one city for a specific year. Among 17 variables of the data, we will focus on the following 9 variables in order to give users a more targeting experience:
+ ORI(unique identifier)
+ year
+ department_name (city name)
+ total_pop (population of the city)
+ violent_per_100k
+ homs_per_100k
+ rape_per_100k
+ rob_per_100k
+ agg_ass_per_100k.

By analyzing ORI and department_name, we are replacing these 2 variables with 2 new ones: State and City, to make it easier for the users to filter the data.

#### 3.	Usage scenario & task
We are currently working on developing several user scenarios:
###### a)	Plotting the data and prediction
Jack has lived in Chicago since he was born, and recently he has been relocated to Atlanta due to employment. He has never been to Atlanta before and wants to know about the crime rate in Atlanta. When he logs into “Crime Data Browser” (name TBD), he can select the State 'GA' and 'City' through the dropdown menus and a range for the year. Once he presses the 'Plot historical data' button, there will be five tabs showing five types of crimes data (homicide, rape, robbery, violent crimes, and aggressive assault). In each tab, the crime count per 10k people will be plotted in a graph. If he hovers the mouse over the plot more information about each data point will be showed in a tooltip. In addition, he can predict the new crime rates based on the historical data available. By entering a year after 2015, he can see a new plot which includes a prediction of crime rate for the selected city in that year. All this information would help Jack have a better understanding of the security level in Atlanta.

###### b)	Sorting the data
Mary is a researcher who is doing a project about police department performance. When she logs into “Crime Data Browser”, she can select a year through the 'Year' dropdown menu, the number of cities to be shown and the ascending or descending order of the data. By pressing the 'Sort data' button', there will be five tabs showing five types of crimes data, and in each of them, the sorted crime data of cities will be displayed in a bar chart for a specific year. She can rank the data from lowest to highest crime rate to see which cities have a lower or higher crime rate.

#### 4.	App Description & initial sketch
 The app has a sidebar to interact with the user. In the top section, the user can choose the state and city and the year range for plotting the available data or a specific year for prediction (Figures 1 and 2). The plots will be shown in five tabs on the right side of the app. On the bottom section, the user can select the year, number of cities to be shown and the order, the plot the sorted data in a bar chart (Figure 3). Each section has a button to submit the user input. If the user hovers the mouse over the graphs, more information about each data point will be shown in a tooltip.  

 <br>
 <center>
 <img src="./pic1.jpg" width="850px"/>
 </center>
 <p style="text-align:center">
 Figure 1. The user choses the State and City and a year range (until 2015) and presses the 'Plot historical data' button. The 'Total crimes' have been plotted in the corresponding Tab.
 </p>
 <br>

 <br>
 <center>
 <img src="./pic2.jpg" width="850px"/>
 </center>
 <p style="text-align:center">
 Figure 2. The user choses the State and City and enters a specific year (after 2015) and presses the 'Predict' button. The 'Total crimes' have been plotted in the corresponding Tab showing the prediction.
 </p>
 <br>

 <br>
 <center>
 <img src="./pic3.jpg" width="850px"/>
 </center>
 <p style="text-align:center">
 Figure 3. The user choses a specific year (before 2015) and enters the number of cities to be plotted and the choses the order of plot from the radio buttons and finally presses the 'Sort data' button. The 'Total crimes' have been plotted in the corresponding Tab showing the sorted data of the top cities for that year.
 </p>
 <br>
