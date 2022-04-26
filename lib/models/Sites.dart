class Sites {
  String _stationName, _description, _coordinates;


  Sites( this._stationName, this._description, this._coordinates);

  factory Sites.fromJSON(Map<String,dynamic> json){

      return Sites(
          json["name"],
          json["description"],
          json["coordinates"]);
  }


  get stationName => this._stationName;
  get description => this._description;
  get coordinates => this._coordinates;
    }


