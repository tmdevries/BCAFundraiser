# And We're Walking (A Fundraising Application)

While this is an application I've built as online auction application with fundraising for breast cancer awareness in mind, it can be repurposed if desired, as only the color scheme and background are specific to the breast cancer theme.

Some major features:

1. Users can browse through items in an active auction and bid on items if the auction has officially started.
2. When a user is the highest bidder on an item, his/her bid is highlighted green in the bid manager and when viewing the item's bid history. The user cannot outbid him/herself.
3. Users can choose to let their first names be visible to other users in bid histories.
4. Users can elect to be notified via email if they are outbid on an item.
5. As an admin, it is possible to add new auctions, add items for each auction, edit the start and end times of each auction (to determine when bidding is allowed) and make auctions active/inactive (to determine whether items will be visible to normal users).
6. As an admin, it is possible to delete bids and see all bids that have been made and by whom.

Future features to be added:

1. At the end of an auction, notify all users whether they have won an item or just thank them for participating if they did not win.
2. At the end of an auction, add up all the winning bids to determine how much money was raised (or earned).
3. Let admins enter anonymous bids when the auction has a live component.
4. Allow users to automatically raise bid amount if outbid.

Some things to keep in mind if you deploy the app for yourself:

1. Please link to my github in order to give me credit for my work. 
2. You must manually add a first user that is an admin through the Rails console or update a user to be an admin. Once at least one user is an admin, that user can make other users admins.
3. The database used is PostgreSQL so it is compatible with Heroku. 
4. The Paperclip gem uses Amazon SW3 to store image files. You must alter this to use the database or enter your own credentials for a file server. Check the environment files to see what to name the variables or to change their names.
