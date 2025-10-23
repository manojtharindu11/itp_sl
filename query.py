"""
Simple Python runner to query the Prolog knowledge base using SWI-Prolog.
Requires `swipl` on PATH.

Functions:
- ask_prolog(query): runs a Prolog query string and returns raw output lines.
- recommend_trip_py(season, budget, start, end): helper that queries recommend_trip/6.

This uses subprocess to call `swipl -s knowledge_base.pl -g "<Query>" -t halt`.
"""
import subprocess
import shlex
import sys
from typing import List

KB_PATH = "knowledge_base.pl"


def ask_prolog(query: str) -> List[str]:
    """Run a Prolog query and return output lines."""
    # Use list args to avoid shell quoting/special-char issues.
    cmd = ["swipl", "-s", KB_PATH, "-g", query, "-t", "halt"]
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


def recommend_trip_py(season: str, budget: str, start: str = 'colombo', end: str = 'ella'):
    # Build Prolog query to print Route and Distance
    query = f"recommend_trip({season}, {budget}, {start}, {end}, Route, Dist), write(Route), write('||'), write(Dist), nl"
    # Ensure atoms are lowercase and without quotes in Prolog; if user passes strings, they must be valid atoms.
    lines = ask_prolog(query)
    results = []
    for line in lines:
        if '||' in line:
            route_part, dist_part = line.split('||', 1)
            route = route_part.strip()
            dist = dist_part.strip()
            results.append({'route': route, 'distance': dist})
    return results


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
