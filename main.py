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
def add_categoria():
    data = request.json
    nombre = data['nombre']
    
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO categorias (nombre) VALUES (%s)", (nombre))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Categoría creada exitosamente'}), 201

# crear subcategoria (pasando categoria)
@app.route('/subcategoria', methods=['POST']) # cat?=id
def add_subcategoria():
    data = request.json
    nombre = data['nombre']
    categoria_id = request.args.get('cat')
    
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO subcategorias (nombre, categoria_id) VALUES (%s, %i)", (nombre, categoria_id))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Subcategoría agregada exitosamente'}), 201

# crear consumibles (en subcategoria)
@app.route('/consumible', methods=['POST']) # sub?=id
def add_consumible():
    data = request.json
    nombre = data['nombre']
    unidad = data['unidad']
    cantidad = data['cantidad']
    imagen = data['imagen']
    subcategoria_id = request.args.get('sub')
    
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO consumibles (nombre, unidad, cantidad, imagen, subcategoria_id) VALUES (%s, %s, %i, %s, %i)", (nombre, unidad, cantidad, imagen, subcategoria_id))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Consumible agregado exitosamente'}), 201

# crear tipo_herramienta (en subcategoria)
@app.route('/tipo-herramienta', methods=['POST']) # sub?=id
def add_tipo_herramienta():
    data = request.json
    nombre = data['nombre']
    #cantidad = data['cantidad']  0
    #disponibles = data['disponibles']  0
    subcategoria_id = request.args.get('sub')
    
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO tipos_herramienta (nombre, cantidad, disponibles, subcategoria_id) VALUES (%s, %i, %i, %i)", (nombre, 0, 0, subcategoria_id))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Consumible agregado exitosamente'}), 201

# alta de herramienta
@app.route('/herramienta', methods=['POST']) # tipo?=id
def add_herramienta():
    data = request.json
    observaciones = data['observaciones']
    imagen = data['imagen']
    tipo_id = request.args.get('tipo')
    
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO herramientas (observaciones, imagen, tipo_id) VALUES (%s, %s, %i)", (observaciones, imagen, tipo_id))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Alta exitosa de la herramienta'}), 201

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


if __name__ == '__main__':
    app.run(debug=True)

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