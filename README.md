# Products 
 
 ## Run Requirements 
 * IOS14
 * XCode Version 13.1
 

  ## OVERVIEW
  - Products is a simple iOS App built using Clean Architecture and MVVM.

## High Level Layers
* **Domain Layer** = Entities + Use Cases + Repositories Interfaces
* **Data Repositories Layer** = Repositories Implementations + API (Network) + Persistence DB
* **Presentation Layer (MVVM)** = ViewModels + Views


##### API (Network)

* **`Service / Networking`** - contains the Router enum that is responsible for the apis structure.
* `Endpoint` - contains the BasAPI singleton class which contains the genaric base api request.
* `Encoding` - contains the all the necessarily encoding methods for building the urls.


* **`Repo`** - contains all the networking repositories that is responsible for getting data from data source.

