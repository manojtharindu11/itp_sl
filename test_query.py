import subprocess
import sys
import os

KB = os.path.join(os.path.dirname(__file__), 'knowledge_base.pl')


def run_prolog_query(query: str) -> str:
    # Use list args to avoid shell quoting issues
    cmd = ["swipl", "-s", KB, "-g", query, "-t", "halt"]
    proc = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if proc.returncode != 0:
        print('Prolog stderr:\n', proc.stderr, file=sys.stderr)
    return proc.stdout.strip()


def test_recommend_mirissa_winter():
    # Use findall to collect all recommendations for winter
    out = run_prolog_query('findall(D, recommend(D, winter), L), write(L), nl')
    # Expected to include mirissa (and possibly galle)
    assert 'mirissa' in out


def test_route_colombo_ella():
    out = run_prolog_query('route(colombo, ella, Path, D), write(Path), write(" "), write(D), nl')
    # Ensure we got a path that includes both endpoints
    assert 'colombo' in out and 'ella' in out
