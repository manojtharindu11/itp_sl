# ITP-SL — Intelligent Travel Planning (Sri Lanka)

This small project demonstrates a Prolog-based expert system for travel recommendations in Sri Lanka.

Prerequisites

- SWI-Prolog (swipl) installed and on PATH
- Python 3.8+ (for the simple runner and tests)
- (Optional) pytest for running tests
- Streamlit (installed via requirements.txt)

Files

- `knowledge_base.pl`: Prolog facts and rules
- `query.py`: Python helper that runs Prolog queries using `swipl`
- `test_query.py`: pytest tests that run a couple of sample queries
- `app.py`: Streamlit UI that calls the Prolog KB and shows an interactive map

Quick run

1. From the `itp_sl` folder, run a sample query in Prolog:

```powershell
swipl -s knowledge_base.pl
?- recommend(D, winter).
```

2. Or use the Python runner:

```powershell
python query.py winter moderate
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

- Atoms passed to `query.py` should be valid Prolog atoms (lowercase, no spaces). You can extend the KB by opening `knowledge_base.pl` and adding facts or using `assert/1` inside the Prolog REPL.
- This scaffold is intentionally minimal. Next steps: add better parsing of Prolog terms in `query.py`, add a Flask/Streamlit UI, integrate PySwip for a tighter Python-Prolog bridge, and add scoring & user preferences.
