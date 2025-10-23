"""
Simple Python runner to query the Prolog knowledge base using SWI-Prolog.
Loads configuration from environment variables via python-dotenv if present.

Environment variables:
- SWIPL_PATH: path to the swipl executable (default: "swipl" on PATH)
- KB_PATH: path to knowledge_base.pl (default: alongside this file)

Functions:
- ask_prolog(query): runs a Prolog query string and returns raw output lines.
- recommend_trip_py(season, budget, start, end): helper that queries recommend_trip/6.

This uses subprocess to call `swipl -s knowledge_base.pl -g "<Query>" -t halt`.
"""
import subprocess
import sys
import ast
import os
from typing import List, Dict, Any

try:
    from dotenv import load_dotenv  # type: ignore
    load_dotenv()
except Exception:
    # Safe to ignore if dotenv is not installed; env vars may still be set
    pass

SWIPL = os.getenv("SWIPL_PATH", "swipl")
DEFAULT_KB = os.path.join(os.path.dirname(__file__), "knowledge_base.pl")
KB_PATH = os.getenv("KB_PATH", DEFAULT_KB)


def ask_prolog(query: str) -> List[str]:
    """Run a Prolog query and return output lines."""
    # Use list args to avoid shell quoting/special-char issues.
    cmd = [SWIPL, "-s", KB_PATH, "-g", query, "-t", "halt"]
    try:
        result = subprocess.run(cmd, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    except subprocess.CalledProcessError as e:
        print("Prolog error:", e.stderr, file=sys.stderr)
        raise
    out = result.stdout.strip()
    if not out:
        return []
    lines = [line.strip() for line in out.splitlines() if line.strip()]
    return lines


def _parse_prolog_list(list_text: str) -> List[str]:
    """Parse a Prolog list written with quoted atoms (e.g., ['colombo','kandy'])."""
    try:
        return ast.literal_eval(list_text)
    except Exception:
        # Fallback: naive parsing without quotes
        t = list_text.strip()
        if t.startswith('[') and t.endswith(']'):
            inner = t[1:-1]
            items = [s.strip().strip("'") for s in inner.split(',') if s.strip()]
            return items
        return []


def recommend_trip_py(season: str, budget: str, start: str = 'colombo', end: str = 'ella') -> List[Dict[str, Any]]:
    """Return a list of route recommendations with parsed route list and distance as int."""
    # Use write_term with quoted(true) so atoms are quoted for Python parsing
    query = (
        f"recommend_trip({season}, {budget}, {start}, {end}, Route, Dist), "
        f"write_term(Route, [quoted(true)]), write('||'), write(Dist), nl"
    )
    lines = ask_prolog(query)
    results: List[Dict[str, Any]] = []
    for line in lines:
        if '||' in line:
            route_part, dist_part = line.split('||', 1)
            route = _parse_prolog_list(route_part)
            try:
                distance = int(dist_part.strip())
            except ValueError:
                try:
                    distance = float(dist_part.strip())
                except Exception:
                    distance = None
            results.append({'route': route, 'distance': distance})
    return results


def get_city_coords(cities: List[str]) -> Dict[str, Dict[str, float]]:
    coords: Dict[str, Dict[str, float]] = {}
    for c in cities:
        lines = ask_prolog(f"city_coord({c}, Lat, Lon), write(Lat), write(','), write(Lon), nl")
        if lines:
            lat_str, lon_str = lines[0].split(',')
            coords[c] = {'lat': float(lat_str), 'lon': float(lon_str)}
    return coords


def get_attractions(cities: List[str]) -> Dict[str, List[str]]:
    res: Dict[str, List[str]] = {}
    for c in cities:
        lines = ask_prolog(
            f"findall(A, attraction({c}, A), L), write_term(L, [quoted(true)]), nl"
        )
        res[c] = _parse_prolog_list(lines[0]) if lines else []
    return res


def get_all_cities() -> List[str]:
    lines = ask_prolog("findall(C, city(C, _, _, _), L), write_term(L, [quoted(true)]), nl")
    return _parse_prolog_list(lines[0]) if lines else []


def city_exists(city: str) -> bool:
    lines = ask_prolog(f"(city({city}, _, _, _) -> write(ok); write(nok)), nl")
    return bool(lines and lines[0] == 'ok')


if __name__ == '__main__':
    if len(sys.argv) >= 3:
        season = sys.argv[1]
        budget = sys.argv[2]
        start = sys.argv[3] if len(sys.argv) > 3 else 'colombo'
        end = sys.argv[4] if len(sys.argv) > 4 else 'ella'
        res = recommend_trip_py(season, budget, start, end)
        if not res:
            print('No recommendations found.')
        else:
            for r in res:
                print('Route:', r['route'])
                print('Distance:', r['distance'])
    else:
        print('Usage: python query.py <season> <budget> [start] [end]')
