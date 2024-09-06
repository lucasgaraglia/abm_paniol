from flask import Flask, request, jsonify
from flask_mysqldb import MySQL
import MySQLdb.cursors

app = Flask(__name__)


# Configuración de la base de datos MySQL
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'panol'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'

mysql = MySQL(app)

# crear categoria
@app.route('/categoria', methods=['POST'])
def create_category():
    data = request.json
    nombre = data['nombre']
    tipo_id = data['tipo_id']
    
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO herramientas (nombre, tipo_id) VALUES (%s, %s)", (nombre, tipo_id))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Herramienta agregada exitosamente'}), 201


# crear subcategoria (pasando categoria)

# crear consumibles (en subcategoria)

# crear tipo_herramienta (en subcategoria)


# alta de herramienta

# baja de herramienta (paso toda la info a bajas, y elimino el registro de herramientas)


# modificacion de categoria

# modificacion de subcategoria

# modificacion de tipo de herramienta

# modificacion de herramienta en especifico

# modificacion de consumible


# eliminar categoria CASCADE

# eliminar subcategoria CASCADE

# eliminar tipo_herramienta CASCADE

# eliminar consumible



# agregar una nueva herramienta
# @app.route('/herramientas', methods=['POST'])
# def add_herramienta():
#     data = request.json
#     nombre = data['nombre']
#     tipo_id = data['tipo_id']
    
#     cursor = mysql.connection.cursor()
#     cursor.execute("INSERT INTO herramientas (nombre, tipo_id) VALUES (%s, %s)", (nombre, tipo_id))
#     mysql.connection.commit()
#     cursor.close()
    
#     return jsonify({'message': 'Herramienta agregada exitosamente'}), 201

# # obtener todas las herramientas
# @app.route('/herramientas', methods=['GET'])
# def get_herramientas():
#     cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
#     cursor.execute("SELECT * FROM herramientas")
#     herramientas = cursor.fetchall()
#     cursor.close()
    
#     return jsonify(herramientas)

# # actualizar una herramienta
# @app.route('/herramientas/<int:id>', methods=['PUT'])
# def update_herramienta(id):
#     data = request.json
#     nombre = data['nombre']
#     tipo_id = data['tipo_id']
    
#     cursor = mysql.connection.cursor()
#     cursor.execute("UPDATE herramientas SET nombre=%s, tipo_id=%s WHERE id=%s", (nombre, tipo_id, id))
#     mysql.connection.commit()
#     cursor.close()
    
#     return jsonify({'message': 'Herramienta actualizada exitosamente'})

# # eliminar una herramienta
# @app.route('/herramientas/<int:id>', methods=['DELETE'])
# def delete_herramienta(id):
#     cursor = mysql.connection.cursor()
#     cursor.execute("DELETE FROM herramientas WHERE id=%s", (id,))
#     mysql.connection.commit()
#     cursor.close()
    
#     return jsonify({'message': 'Herramienta eliminada exitosamente'})

if __name__ == '__main__':
    app.run(debug=True)