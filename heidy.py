import pandas as pd
import psycopg2
import sklearn
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score


conexion = psycopg2.connect(
    host ="localhost",
    database="convivec_ia",
    user="postgres",
    password="1234",
    port="5432"
)

query = "SELECT u.nombre, r.fecha_reserva FROM usuario u JOIN reserva r ON u.id_usuario = r.id_usuario;"

query = """SELECT u.nombre, r.nombre_rol, s.tipo_solicitud, s.fecha_registro
        FROM usuario u
        JOIN solicitud s ON u.id_usuario = s.id_usuario 
        JOIN rol r ON u.id_rol = r.id_rol
        WHERE s.fecha_registro BETWEEN '2026-10-01' AND '2026-10-12'
        AND(s.id_solicitud = 3 OR s.id_solicitud = 8);"""




query = """SELECT s.tipo_solicitud, s.prioridad, u.torre, s.fecha_registro
        FROM solicitud s
        JOIN usuario u ON s.id_usuario = u.id_usuario;"""





df = pd.read_sql(query, conexion)
print(df)

query_reserva = "SELECT id_reserva, id_zona, hora_inicio, hora_fin FROM reserva;"
df_reserva = pd.read_sql(query_reserva, conexion)

#df_reserva['duracion'] = df_reserva['hora_fin'] - df_reserva['hora_inicio']

df_reserva['duracion'] = df_reserva.apply(lambda d: d['hora_fin'] - d['hora_inicio'], axis = 1)
print(df_reserva['duracion'])

#cantidad_peticiones = (df['tipo_solicitud'] == 'peticion').sum()
cantidad_peticiones = df['tipo_solicitud'].apply(lambda p: 1 if p == 'peticion' else 0).sum()
print(df[df['tipo_solicitud'] == 'peticion'])
df['tipo_solicitud_num'] = df['tipo_solicitud'].astype('category').cat.codes
print(df)

df['prioridad_num'] = df['prioridad'].astype('category').cat.codes
df['torre_num'] = df['torre'].astype('category').cat.codes

X = df[['prioridad_num', 'torre_num']]
Y = df['tipo_solicitud_num'] 




X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.2, random_state=42)

modelo =  DecisionTreeClassifier ()
modelo.fit(X_train, Y_train)

predicciones = modelo.predict(X_test)
precision = accuracy_score(Y_test, predicciones)
print(f"Precision del modelo: {precision * 100}%")
      
conexion.close()