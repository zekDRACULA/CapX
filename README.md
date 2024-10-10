# CapX
 
Overview

The Stock Lookup App is an iOS application built with SwiftUI that provides users with real-time stock information. It fetches data from an external API to display stock details such as the current price, price change, 52-week high/low, and more. It also includes a feature to show historical price data for different intervals like 1 month, 6 months, 1 year, and 5 years.

Features

Search for Stocks: Enter a stock symbol to retrieve real-time information.
Stock Details Display:
Current stock price
Price change from the previous close
High and low of the day
52-week high and low prices
Historical Data: Fetch and display historical stock prices for different time intervals.
Price Chart: Visual representation of stock price trends using line charts.
Segmentation Control: Switch between different time intervals (1 month, 6 months, 1 year, 5 years) to see historical data.
Responsive UI: The app automatically updates the price and chart based on the latest data fetched.

Screenshots

DARK MODE

![1](https://github.com/user-attachments/assets/bdae2b0d-a35d-4e34-8813-9a86b9631005)

![2](https://github.com/user-attachments/assets/885d7dfc-648a-4e82-8cd9-1f8f1e9613f8)

![3](https://github.com/user-attachments/assets/73ee5496-75f1-496a-8be0-f12b1b9b378f)

![4](https://github.com/user-attachments/assets/fbe9f8f1-fe18-44e7-8093-69a4dd9df32a)

![1'](https://github.com/user-attachments/assets/4eb7b452-6f4e-4616-a77e-7956a4afd13c)

![2'](https://github.com/user-attachments/assets/9c1a58c5-fe9e-495f-8146-54167314e7f8)

![4'](https://github.com/user-attachments/assets/f1f43083-060e-47ce-b79b-5ba8fec74fe4)

Architecture

The app follows the MVVM (Model-View-ViewModel) architecture pattern:

Model: Represents the stock information data structure and API responses.
View: SwiftUI views displaying stock information, charts, and user interface elements.
ViewModel: The DataManager and stockInfoManager handle business logic, API calls, and updating the views based on changes to the data.
How It Works

Search Stock: The user inputs the stock symbol into the search bar and presses the search button.
The app calls the stock information API using the entered symbol.
The real-time stock data and historical price data are fetched and displayed.
Segmented Control: Users can switch between different time intervals (1M, 6M, 1Y, 5Y) using the segmented control, and the app fetches and displays the relevant historical data.
Dynamic UI Updates: The price change (positive/negative) and historical chart update automatically based on the fetched data.
Installation and Setup

Prerequisites
Xcode 13.0+ for iOS/macOS development.
Swift 5.0+
CocoaPods (if required by any third-party libraries).
Steps to Run Locally
Clone the repository:
bash
Copy code
git clone https://github.com/your-username/stock-lookup-app.git
cd stock-lookup-app
Open the project in Xcode:
bash
Copy code
open StockLookupApp.xcodeproj
Install any dependencies (if applicable):
bash
Copy code
pod install
Run the app on your simulator or device:
Select your target device.
Press Cmd + R or click the play button in Xcode.
API Integration

The app fetches stock data using two main API calls:

Stock Information API: Provides details like current price, high, low, etc.
Stock History API: Returns historical price data for different intervals.
Replace the placeholders with your own API credentials and endpoint URLs in the networking code.

Future Improvements

Favorites Feature: Allow users to mark certain stocks as favorites and view them in a separate section.
Custom Alerts: Notify users when a stock reaches a certain price.
Advanced Charts: Add more detailed charts with technical indicators like moving averages.
Contributing

If you'd like to contribute to the development of this app:

Fork the repository.
Create a new branch (git checkout -b feature-branch).
Commit your changes (git commit -m 'Add some feature').
Push to the branch (git push origin feature-branch).
Open a pull request.
License

This project is licensed under the MIT License - see the LICENSE file for details.

Contact

For any questions or feedback, feel free to reach out:

Email: your.email@example.com
GitHub: your-username
