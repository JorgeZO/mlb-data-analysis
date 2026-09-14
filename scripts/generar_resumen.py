"""Regenera los indicadores del CSV con precisión decimal explícita."""
import csv
from decimal import Decimal, ROUND_HALF_UP
from pathlib import Path

carpeta = Path(__file__).resolve().parents[1] / 'data' / 'processed'
with (carpeta / 'bateadores_2025.csv').open(encoding='utf-8', newline='') as archivo:
    lector = csv.DictReader(archivo)
    columnas = lector.fieldnames + ['promedio_bateo', 'hr_por_100_apariciones']
    filas = list(lector)

for fila in filas:
    for campo, numerador, denominador, precision in [
        ('promedio_bateo', Decimal(fila['hits']), Decimal(fila['turnos']), '0.001'),
        ('hr_por_100_apariciones', 100 * Decimal(fila['home_runs']),
         Decimal(fila['apariciones_plato']), '0.01'),
    ]:
        fila[campo] = str((numerador / denominador).quantize(
            Decimal(precision), rounding=ROUND_HALF_UP)) if denominador else ''

filas.sort(key=lambda f: (
    Decimal(f['promedio_bateo']) if f['promedio_bateo'] else Decimal('-1'),
    int(f['turnos'])
), reverse=True)
with (carpeta / 'resumen_bateadores_2025.csv').open('w', encoding='utf-8', newline='') as archivo:
    escritor = csv.DictWriter(archivo, fieldnames=columnas)
    escritor.writeheader()
    escritor.writerows(filas)
print(f'Resumen generado: {len(filas)} registros.')
