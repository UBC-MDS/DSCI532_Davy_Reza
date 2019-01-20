Crime data browser
================
Reza Bagheri and Weifeng Davy Guo
2019-01-19

Our app can be viewed at: <https://davygriffin.shinyapps.io/crime_data_browser/>.

### Rationale

In our proposal, we came out two scenarioes related to our app crime data browser. For the `Plotting the data and prediction` part, we choose using lineplot to plot the history data of a chosen city from chosen state. For the `Sorting the data` part, we use bar chart to compare the crime data for several cities from a selected year in asecending or descending order.

### Functionality

Once logged in the app, user can see the layout showed as below: <img src ="img/pic1.png">

User can select state, city and the year range, a lineplot will show up to display the history data through selected year range. The chart will update accordingly while user change their selection:

<img src ="img/pic2.png">

We have 5 seperated tabs to show the data based on crime type. In this way, user could view the data in a more detailed way:

<img src ="img/pic3.png"> <img src ="img/pic4.png">

If the user put button of slide bar overlapped, means the time became a selected year, the chart will become a bar chart to display the the crime data in asecending or descending order (chosen by user):

<img src ="img/pic5.png">

And the user can determine how many cities they'd like to display (from at least 2 to at most 15): <img src ="img/pic6.png"> <img src ="img/pic7.png">

### Visions & unfinished steps

Based on our visions, we are working on the prediction function, which will display a predicted crime data and will be plotted in dash line.

There is several improving part of our app: we've noticed that the slidebar of the Year will make user confused, since the time range and time point will bring up 2 different outcome, We will keep working on a more clear layout of the sidebar.
