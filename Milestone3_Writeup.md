Crime data browser
================
Reza Bagheri and Weifeng Davy Guo
2019-01-24

Our app can be viewed at: <https://davygriffin.shinyapps.io/crime_data_browser/>.

### Feedbacks and changes

After the second milestone we received these feedbacks from the TA:

-   Suggesting to change the plot colour based on the type of crime user selects

-   Rotating the names of the cities to avoid overlap

-   Adding more ticks for the year axis for clarity

-   Separating the bar plot widgets 

-   Asking why the state widget doesn't work for a barplot

-   Requesting to add an "all cities" feature for the line plot so that the user can see the average for all cities in the selected state

-   Changing the variable names to be more specific and informative

-   For the "number of cities", having an option to select one city 

-   Writing more functions to avoid repetition

After the feedback session, we received 2 feedbacks from other groups as well. The feedbacks were generally positive. They believed that the role of year slider to show the bar charts is hidden and not clear.  They had a comment about the rotation of the text label of the bar chart and using different colors in the plots which were addresses before. They also suggested to show all the categories in one plot. So what was common between all the feedbacks was the suggesting to use different color. more clarification on the year slider and rotation of the text labels. We guess the clarification for the year slider is very important here.
So we decided to make lots of changes. We added a help text below the slider to clarify that. We made the following changes:


+ *We've changed plot colour based on the type of crime, both line chart and bar chart.* 

<img src ="img/pic10.png">

<img src ="img/pic11.png">

+ *They axis text labels in the bar chart are rotated now.*

+ *More ticks have been added to line plot axis.*

+ *There are now line separators for each section on the panel with titles and there are also some help texts on the panel that describe the widget functions.*

<img src ="img/pic13.png">

+ *Now there is a second plot on the bottom that shows the average values for each state.* 

<img src ="img/pic14.png">

+ *You can now select one city from the slider.*

+ *We tried to add variables with more informative names.*

+ *We now have some functions in our code to plot the data for each crime category.*

+ *We have added a help text below the slider bar to explain how it works.*


There was a comment asking to show several categories in one plot, however, we decided not to do that. However, we have decided not to do that. That is because we adding the predictions and showing all the curves with their regression lines and new points makes the plot very crowded and difficult to read.

We also received a comment that the state widget doesn't work for a barplot. This is not a bug. The bar plot shows the country-wide data not the state data. That's because most of the states only have one city. Se we added a help text to the panel to clarify what it is plotting.
We think that receiving those feedbacks were very useful for improving our app and now our app looks much better. We figured out which parts of the app interface was confusing and which parts needed improvement. This was an instructive experience for us.


### Updates since Milestone 2

As mentioned earlier, we focused on improving the design of the app since milestone 2.

-   We have added a dark theme to the app.

-   We've added another line chart to display the average statistics in selected states.

-   We've change the chart color based on crime type so user will clearly see the difference.

-   We've added help text to the panel and divided it with lines to help the user how to use the app.


-The most important feature we added is the prediction section that uses linear regression. The user should enter a year after 2015 and then click "Add" button. If the user enters a a year before 2015 or something which is not a number, the app will show an error message.

<img src ="img/pic16.png">

After pressing the button a linear regression will be done on the whole data set and the new values for each crime category will be calculated for the new year. The new data point and regression line will be shown in the line plot. The user can switch between tabs or even switch to the bar plots to see the sorted data for the new year. If the user selects a year range after 2015 and before new year, the app will give a warning that no data is available to show.

<img src ="img/pic15.png">

By pressing the 'Remove' button all the predictions will be removed from the plot. When you do a regression analysis, it is possible that you end up with negative numbers for your prediction. This may happens for the cities that have a declining crime rate. In that case showing a negative crime rate may be meaninless, so the app sets the negative numbers to zero.

<img src ="img/pic17.png">


We are glad to see that we have implemented all the features of our app according to our proposal. Hence, our objectives remain unchanged.
