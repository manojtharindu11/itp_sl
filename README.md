# ITP-SL — Intelligent Travel Planning (Sri Lanka)

This small project demonstrates a Prolog-based expert system for travel recommendations in Sri Lanka.

Prerequisites

- SWI-Prolog (swipl) installed and on PATH
- Python 3.8+ (for the simple runner and tests)
- (Optional) pytest for running tests

Files

- `knowledge_base.pl`: Prolog facts and rules
- `query.py`: Python helper that runs Prolog queries using `swipl`
- `test_query.py`: pytest tests that run a couple of sample queries

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

Notes

- Atoms passed to `query.py` should be valid Prolog atoms (lowercase, no spaces). You can extend the KB by opening `knowledge_base.pl` and adding facts or using `assert/1` inside the Prolog REPL.
- This scaffold is intentionally minimal. Next steps: add better parsing of Prolog terms in `query.py`, add a Flask/Streamlit UI, integrate PySwip for a tighter Python-Prolog bridge, and add scoring & user preferences.
