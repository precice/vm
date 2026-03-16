import tarfile
import urllib.request

try:
    req = urllib.request.urlopen('https://www.code-aster.org/FICHIERS/aster-full-src-14.6.0-1.noarch.tar.gz')
    with tarfile.open(fileobj=req, mode='r|gz') as tar:
        found_setup = False
        found_cfg = False
        for member in tar:
            if member.name.endswith('setup.py'):
                f = tar.extractfile(member)
                if f:
                    print(f"--- {member.name} ---")
                    print(f.read().decode('utf-8')[:3000])
                found_setup = True
            elif member.name.endswith('setup.cfg'):
                f = tar.extractfile(member)
                if f:
                    print(f"--- {member.name} ---")
                    print(f.read().decode('utf-8')[:4000])
                found_cfg = True
            if found_setup and found_cfg:
                break
except Exception as e:
    print(f"Error: {e}")
