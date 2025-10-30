# ITP-SL — Intelligent Travel Planning (Sri Lanka)

This small project demonstrates a Prolog-based expert system for travel recommendations in Sri Lanka.

Prerequisites

- SWI-Prolog (swipl) installed and on PATH
- Python 3.8+ (for the simple runner and tests)
- (Optional) pytest for running tests
- Streamlit (installed via requirements.txt)

Project Structure

- `knowledge_base.pl`: Bootstrap file that loads modular Prolog knowledge base
- `kb/`: Modular Prolog knowledge base files
  - `cities.pl`: City facts (name, attractions, season, budget)
  - `attractions.pl`: Tourist attractions by city
  - `coords.pl`: Geographic coordinates for cities
  - `distances.pl`: Inter-city distances
  - `modes.pl`: Transportation modes
  - `seasons.pl`: Seasonal information
  - `budgets.pl`: Budget categories
  - `monsoon.pl`: Monsoon season facts
  - `rules.pl`: Prolog inference rules for recommendations
- `app/`: Python application code
  - `query.py`: Python helper that runs Prolog queries using `swipl`
  - `utils/config.py`: Configuration management with environment variables
  - `utils/map_layers.py`: Map rendering utilities (OSM/Mapbox)
- `test/test_.py`: pytest tests for Prolog queries
- `app.py`: Streamlit UI that calls the Prolog KB and shows an interactive map

Quick run

1. From the `itp_sl` folder, run a sample query in Prolog:

```powershell
swipl -s knowledge_base.pl
?- recommend(D, winter).
```

2. Or use the Python runner:

```powershell
python app/query.py winter moderate colombo ella
```

Run tests (with pytest):

```powershell
pytest -q
```

Run the Streamlit app (UI)

1. Install dependencies (ideally in a virtual environment):

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

2. Start the app (requires SWI-Prolog `swipl` on PATH):

```powershell
streamlit run app.py
```

3. Open the URL printed in the terminal (usually http://localhost:8501). To stop the app, press Ctrl+C in the terminal.

Environment variables (.env)

You can configure paths and tokens without hardcoding them. Copy the sample and edit as needed:

```powershell
Copy-Item .env.example .env
# then edit .env in your editor
```

Supported variables:

- `SWIPL_PATH`: Full path to the `swipl` executable if not on PATH (e.g., `C:\Program Files\swipl\bin\swipl.exe`).
- `KB_PATH`: Path to `knowledge_base.pl` (defaults to the file in this folder).
- `USE_MAPBOX`: `true` to use Mapbox basemap in the UI; otherwise OpenStreetMap tiles are used.
- `MAPBOX_TOKEN`: Your Mapbox access token (required if `USE_MAPBOX=true`).
- `MAPBOX_STYLE`: Mapbox style URI, defaults to `mapbox://styles/mapbox/streets-v11`.
- `OSM_TILE_URL`: Custom OSM tile URL template if you host your own tiles.

Notes

- Atoms passed to `app/query.py` should be valid Prolog atoms (lowercase, no spaces). You can extend the KB by editing files in the `kb/` directory or using `assert/1` inside the Prolog REPL.
- The knowledge base is modular: each `.pl` file in the `kb/` folder handles a specific domain (cities, attractions, distances, etc.).
- The application uses subprocess to communicate with SWI-Prolog, parsing structured output for routes, distances, and coordinates.
- Map rendering supports both OpenStreetMap (default) and Mapbox (via configuration).
