# Meal-Tracker-App
This app implements a meal tracker. 
The user can create meal entities, which contain the fields: meal name, meal category, calorie count, protein, fat, carbohydrates, and date consumed. 
These entities are displayed in a table view, in which the user can tap on a cell to display all attributes of the meal. 
The user may also swipe on a cell to delete the meal from the database. 

Creating a meal with empty "calories", "protein", "fat", and "carbs" text fields should create a meal object with a calorie count of 0 kcal, 
and protein, fat, and carb amounts of 0.0 grams. If an empty, improper, or improperly formatted date is entered when creating a meal, then 
it should have a default date of “01/01/1970”. This should also apply to proper dates that do not conform to the "dd/mm/yyyy" format. So if "01-01-2021" is 
entered into the date field, this will be changed to "01/01/1970" when creating the meal, as it does not conform to the specified date format. If a meal 
with an empty category text field, or a category that is not "Breakfast", "Lunch", "Dinner", or "Snack" is created, it should have the same image as 
“Snack” category meals. However, the tableviews in "Categories" tab will not display this item. For example, if a meal with category "religious meal" is 
created, it will be shown in the "All Meals" tab, but should be shown in the "Categories" tab.

Deleting a meal can be done by swiping a cell. 
If a meal is deleted in the Categories tab, immediately going to the "All Meals" should reflect this change. 
This should also be true for the reverse.

The settings page should have a picker view containing various settings for which the data populating the table views in the other tabs is sorted. 
Selecting a picker view row and tapping “Save” should immediately sort the table views in the other tabs based on the chosen setting. 
Going to the other tabs should immediately show table views that reflect this change. 
In other words, the user should not have to manually refresh the table view to see these changes in sorting. 
The chosen setting will also sort the table views in the "Categories" tab. 
By default, all table views in the app will be sorted by the most recent date. 
Additionally, any meal created should be immediately placed in the table view in a manner reflecting the current setting. 
Therefore, if a meal with a date more recent than any other meal in the table view is created, and the current setting chosen is "Date", 
that meal should be immediately placed at the top of the table view. Likewise, if the current setting is "Calories", and a meal is created with the 
2nd highest calorie count among all meals in the table, the meal should immediately be placed 2nd in the table view. Choosing the "Categories" 
setting will group the meals in the "All Meals" controller by their respective category. However, in the "Categories" tab, since the meals are already 
filtered by category, this should sort the meals alphabetically by their name.

