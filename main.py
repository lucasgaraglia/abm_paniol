from flask import Flask, request, jsonify
from flask_mysqldb import MySQL
import MySQLdb.cursors
from flask_cors import CORS

from werkzeug.utils import secure_filename
import os
import uuid

app = Flask(__name__)
CORS(app) 


# Configuración de la base de datos MySQL
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'panol'
app.config['MYSQL_HOST'] = 'localhost'

mysql = MySQL(app)

@app.errorhandler(404)
def not_found(error):
    return "Ruta no encontrada."
    
# get categorias
@app.route('/categorias', methods=['GET'])
def get_categorias():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT id, nombre FROM categorias")
    categorias = cursor.fetchall()
    cursor.close()
    
    return jsonify(categorias), 200

# get subcategorias
@app.route('/subcategorias', methods=['GET'])
def get_subcategorias():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT id, nombre, categoria_id FROM subcategorias")
    subcategorias = cursor.fetchall()
    cursor.close()
    
    return jsonify(subcategorias), 200

# get consumibles
@app.route('/consumibles', methods=['GET'])
def get_consumibles():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT co.id, co.nombre, co.unidad, co.cantidad, co.imagen, co.subcategoria_id, sc.nombre as subcagetoria_nombre, ca.id as categoria_id, ca.nombre as categoria_nombre FROM consumibles co INNER JOIN subcategorias sc ON co.subcategoria_id = sc.id INNER JOIN categorias ca ON sc.categoria_id = ca.id")
    subcategorias = cursor.fetchall()
    cursor.close()
    
    return jsonify(subcategorias), 200

# get tipos herramienta
@app.route('/tipos-herramienta', methods=['GET'])
def get_tipos_herramienta():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT th.id, th.nombre, th.cantidad, th.disponibles, th.subcategoria_id, sc.nombre as subcategoria_nombre, sc.categoria_id, ca.nombre as categoria_nombre FROM tipos_herramienta th INNER JOIN subcategorias sc ON th.subcategoria_id = sc.id INNER JOIN categorias ca ON sc.categoria_id = ca.id")
    tipos = cursor.fetchall()
    cursor.close()
    
    return jsonify(tipos), 200


# get herramientas
@app.route('/herramientas', methods=['GET'])
def get_herramientas():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT h.id, h.imagen, h.observaciones, h.tipo_id, th.nombre as tipo_nombre, th.subcategoria_id, sc.nombre as subcategoria_nombre, sc.categoria_id, ca.nombre as categoria_nombre FROM herramientas h INNER JOIN tipos_herramienta th ON h.tipo_id = th.id INNER JOIN subcategorias sc ON th.subcategoria_id = sc.id INNER JOIN categorias ca ON sc.categoria_id = ca.id")
    herramientas = cursor.fetchall()
    cursor.close()
    
    return jsonify(herramientas), 200

# get herramientas dadas de baja
@app.route('/herramientas-bajas', methods=['GET'])
def get_herramientas_bajas():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT h.id, h.imagen, h.observaciones, h.tipo_id, th.nombre as tipo_nombre, th.subcategoria_id, sc.nombre as subcategoria_nombre, sc.categoria_id, ca.nombre as categoria_nombre FROM baja_herramientas h INNER JOIN tipos_herramienta th ON h.tipo_id = th.id INNER JOIN subcategorias sc ON th.subcategoria_id = sc.id INNER JOIN categorias ca ON sc.categoria_id = ca.id")
    herramientas = cursor.fetchall()
    cursor.close()
    
    return jsonify(herramientas), 200

# get 1 categoria
@app.route('/categoria', methods=['GET'])
def get_categoria():
    id = request.args.get('id')
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT id, nombre FROM categorias WHERE categoria_id = %s", id)
    categoria = cursor.fetchall()
    cursor.close()
    
    return jsonify(categoria), 200

# get 1 subcategoria
@app.route('/subcategoria', methods=['GET'])
def get_subcategoria():
    id = request.args.get('id')
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT sc.id, sc.nombre, sc.categoria_id, c.nombre as categoria_nombre FROM subcategorias sc INNER JOIN categorias c ON sc.categoria_id = c.id WHERE sc.id = %s", id)

    subcategoria = cursor.fetchall()
    cursor.close()
    
    return jsonify(subcategoria), 200

# get 1 consumible
@app.route('/consumible', methods=['GET'])
def get_consumible():
    id = request.args.get('id')
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT co.id, co.nombre, co.unidad, co.cantidad, co.imagen, co.subcategoria_id, sc.nombre as subcategoria_nombre, sc.categoria_id, c.nombre as categoria_nombre FROM consumibles co INNER JOIN subcategorias sc ON co.subcategoria_id = sc.id INNER JOIN categorias c ON sc.categoria_id = c.id WHERE co.id = %s", id)

    consumible = cursor.fetchall()
    cursor.close()
    
    return jsonify(consumible), 200

# get 1 tipo herramienta
@app.route('/tipo-herramienta', methods=['GET'])
def get_tipo_herramienta():
    id = request.args.get('id')
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT th.id, th.nombre, th.cantidad, th.disponibles, th.subcategoria_id, sc.nombre as subcategoria_nombre, sc.categoria_id, c.nombre as categoria_nombre FROM tipos_herramienta th INNER JOIN subcategorias sc ON th.subcategoria_id = sc.id INNER JOIN categorias c ON sc.categoria_id = c.id WHERE co.id = %s", id)

    tipo = cursor.fetchall()
    cursor.close()
    
    return jsonify(tipo), 200

# get 1 herramienta
@app.route('/herramienta', methods=['GET'])
def get_herramienta():
    id = request.args.get('id')
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT h.id, h.imagen, h.observaciones, h.tipo_id, th.nombre as tipo_nombre, th.subcategoria_id, sc.nombre as subcategoria_nombre, sc.categoria_id, ca.nombre as categoria_nombre FROM herramientas h INNER JOIN tipos_herramienta th ON h.tipo_id = th.id INNER JOIN subcategorias sc ON th.subcategoria_id = sc.id INNER JOIN categorias ca ON sc.categoria_id = ca.id WHERE h.id = %s", id)

    herramienta = cursor.fetchall()
    cursor.close()
    
    return jsonify(herramienta), 200

# GET baja herramientas
@app.route('/herramienta-baja', methods=['GET'])
def get_herramienta_baja():
    id = request.args.get('id')
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT h.id, h.imagen, h.observaciones, h.tipo_id, th.nombre as tipo_nombre, th.subcategoria_id, sc.nombre as subcategoria_nombre, sc.categoria_id, ca.nombre as categoria_nombre FROM baja_herramientas h INNER JOIN tipos_herramienta th ON h.tipo_id = th.id INNER JOIN subcategorias sc ON th.subcategoria_id = sc.id INNER JOIN categorias ca ON sc.categoria_id = ca.id WHERE h.id = %s", id)

    herramienta = cursor.fetchall()
    cursor.close()
    
    return jsonify(herramienta), 200

# crear categoria
@app.route('/categoria', methods=['POST'])
def add_categoria():
    data = request.json
    nombre = data['nombre']
    
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO categorias (nombre) VALUES (%s)", (nombre,))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Categoría creada exitosamente'}), 201

# crear subcategoria (pasando categoria)
@app.route('/subcategoria', methods=['POST'])
def add_subcategoria():
    data = request.json
    nombre = data['nombre']
    categoria_id = data['categoria_id']
    
    cursor = mysql.connection.cursor()
    cursor.execute(f"INSERT INTO subcategorias (nombre, categoria_id) VALUES (%s, %s)", (nombre, categoria_id))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Subcategoría agregada exitosamente'}), 201

# form-data
# crear consumibles (en subcategoria)
@app.route('/consumible', methods=['POST'])
def add_consumible():
    nombre = request.form.get('nombre')
    unidad = request.form.get('unidad')
    cantidad = request.form.get('cantidad')
    subcategoria_id = request.form.get('subcategoria_id')

    if not nombre or not unidad or not cantidad or not subcategoria_id:
        return jsonify({'error': 'Faltan datos requeridos'}), 400

    imagen_path = None
    if 'imagen' in request.files:
        imagen = request.files['imagen']
        if imagen.filename != '':
            basepath = os.path.dirname(__file__)
            filename = secure_filename(imagen.filename)
            extension = os.path.splitext(filename)[1]
            new_filename = "consumible_" + filename
            upload_path = os.path.join(basepath, 'uploads', new_filename)
            imagen.save(upload_path)
            imagen_path = "uploads/" + new_filename

    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO consumibles (nombre, unidad, cantidad, imagen, subcategoria_id) VALUES (%s, %s, %s, %s, %s)", (nombre, unidad, cantidad, imagen_path, subcategoria_id))
    mysql.connection.commit()
    cursor.close()

    return jsonify({'message': 'Consumible agregado exitosamente'}), 201

# crear tipo_herramienta (en subcategoria)
@app.route('/tipo-herramienta', methods=['POST'])
def add_tipo_herramienta():
    data = request.json
    nombre = data['nombre']
    subcategoria_id = data['subcategoria_id']
    
    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO tipos_herramienta (nombre, cantidad, disponibles, subcategoria_id) VALUES (%s, %s, %s, %s)", (nombre, 0, 0, subcategoria_id))
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Tipo de herramienta agregado exitosamente'}), 201

# VIA FORM-DATA
# alta de herramienta
@app.route('/herramienta', methods=['POST'])
def add_herramienta():
    observaciones = request.form.get('observaciones')
    tipo_id = request.form.get('tipo_id')

    if not observaciones or not tipo_id:
        return jsonify({'error': 'Faltan datos requeridos'}), 400

    imagen_path = None
    if 'imagen' in request.files:
        imagen = request.files['imagen']
        if imagen.filename != '':
            basepath = os.path.dirname(__file__)
            filename = secure_filename(imagen.filename)
            extension = os.path.splitext(filename)[1]
            new_filename = "asdasdasd" + extension
            upload_path = os.path.join(basepath, 'uploads', new_filename)
            imagen.save(upload_path)
            imagen_path = "uploads/" + new_filename

    cursor = mysql.connection.cursor()
    cursor.execute("INSERT INTO herramientas (observaciones, imagen, tipo_id) VALUES (%s, %s, %s)", (observaciones, imagen_path, tipo_id))

    # consulta para afectar a cantidad de tipo_herramienta
    cursor.execute("""
        UPDATE tipos_herramienta
        SET cantidad = cantidad + 1, disponibles = disponibles + 1
        WHERE id = %s
    """, (tipo_id,))
    mysql.connection.commit()
    cursor.close()

    return jsonify({'message': 'Alta exitosa de la herramienta'}), 201



# baja de herramienta (paso toda la info a bajas, y elimino el registro de herramientas)
@app.route('/herramienta', methods=['DELETE'])
def baja_herramienta():
    id = request.args.get('id')
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

    # Obtener la herramienta con todos sus campos
    cursor.execute("SELECT id, imagen, observaciones, tipo_id FROM herramientas WHERE id = %s", (id,))
    herramienta = cursor.fetchone()

    if not herramienta:
        cursor.close()
        return jsonify({'message': 'Herramienta no encontrada'}), 404

    # Insertar los datos de la herramienta en la tabla baja_herramientas
    cursor.execute("""
        INSERT INTO baja_herramientas (id, observaciones, imagen, tipo_id)
        VALUES (%s, %s, %s, %s)
    """, (herramienta['id'], herramienta['observaciones'], herramienta['imagen'], herramienta['tipo_id']))

    # Eliminar la herramienta de la tabla herramientas
    cursor.execute("DELETE FROM herramientas WHERE id = %s", (id,))
    
    # Actualizar la cantidad y disponibles del tipo de herramienta
    cursor.execute("""
        UPDATE tipos_herramienta
        SET cantidad = cantidad - 1, disponibles = disponibles - 1
        WHERE id = %s
    """, (herramienta['tipo_id'],))
    
    mysql.connection.commit()
    cursor.close()

    return jsonify({'message': 'Herramienta dada de baja exitosamente'}), 200



# modificacion de categoria
@app.route("/categoria", methods=['PUT'])
def modificar_categoria():
    id = request.args.get('id')
    data = request.json
    nombre = data['nombre']

    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

    cursor.execute("""
        UPDATE categorias
        SET nombre = %s
        WHERE id = %s
    """, (nombre, id))
    mysql.connection.commit()
    cursor.close()

    return jsonify({'message': 'Categoría modificada exitosamente'}), 200

# modificación de subcategoria - nombre y categoria_id
@app.route("/subcategoria", methods=['PUT'])
def modificar_subcategoria():
    id = request.args.get('id')
    data = request.json
    nombre = data.get('nombre')
    categoria_id = data.get('categoria_id')

    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

    # Actualizar tanto el nombre como el categoria_id si están presentes en el request
    cursor.execute("""
        UPDATE subcategorias
        SET nombre = %s, categoria_id = %s
        WHERE id = %s
    """, (nombre, categoria_id, id))

    mysql.connection.commit()
    cursor.close()

    return jsonify({'message': 'Subcategoría modificada exitosamente'}), 200



# modificacion de tipo de herramienta
@app.route("/tipo-herramienta", methods=['PUT'])
def modificar_tipo_herramienta():
    id = request.args.get('id')
    data = request.json
    nombre = data.get('nombre')
    cantidad = data.get('cantidad')
    disponibles = data.get('disponibles')
    subcategoria_id = data.get('subcategoria_id')

    cursor = mysql.connection.cursor()

    # Verificar si el tipo_herramienta existe
    cursor.execute("SELECT * FROM tipos_herramienta WHERE id = %s", (id,))
    tipo_herramienta = cursor.fetchone()

    if not tipo_herramienta:
        cursor.close()
        return jsonify({'message': 'Tipo de herramienta no encontrado'}), 404

    # Actualizar los campos modificables
    cursor.execute("""
        UPDATE tipos_herramienta 
        SET nombre = %s, cantidad = %s, disponibles = %s, subcategoria_id = %s
        WHERE id = %s
    """, (nombre, cantidad, disponibles, subcategoria_id, id))

    mysql.connection.commit()
    cursor.close()

    return jsonify({'message': 'Tipo de herramienta actualizado exitosamente'}), 200

# form-data
# Modificación de herramienta en específico
@app.route("/herramienta", methods=['PUT'])
def modificar_herramienta():
    id = request.args.get('id')
    if not id:
        return jsonify({'error': 'Falta el parámetro id'}), 400

    observaciones = request.form.get('observaciones')
    tipo_id = request.form.get('tipo_id')

    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

    # Verificar si se subió una nueva imagen
    if 'imagen' in request.files:
        imagen = request.files['imagen']
        if imagen.filename != '':
            basepath = os.path.dirname(__file__)
            filename = secure_filename(imagen.filename)
            extension = os.path.splitext(filename)[1]
            new_filename = "asdasdasd" + extension
            upload_path = os.path.join(basepath, 'uploads', new_filename)
            imagen.save(upload_path)
            imagen_path = upload_path

            # Actualizar los campos de la herramienta incluyendo la imagen
            cursor.execute("""
                UPDATE herramientas
                SET imagen = %s, observaciones = %s, tipo_id = %s
                WHERE id = %s
            """, (imagen_path, observaciones, tipo_id, id))
        else:
            # Actualizar los campos de la herramienta sin la imagen
            cursor.execute("""
                UPDATE herramientas
                SET observaciones = %s, tipo_id = %s
                WHERE id = %s
            """, (observaciones, tipo_id, id))
    else:
        # Actualizar los campos de la herramienta sin la imagen
        cursor.execute("""
            UPDATE herramientas
            SET observaciones = %s, tipo_id = %s
            WHERE id = %s
        """, (observaciones, tipo_id, id))

    mysql.connection.commit()
    cursor.close()

    return jsonify({'message': 'Herramienta modificada exitosamente'}), 200


# modificacion de consumible

@app.route("/consumible", methods=['PUT'])
def modificar_consumible():
    id = request.args.get('id')
    nombre = request.form.get('nombre')
    unidad = request.form.get('unidad')
    cantidad = request.form.get('cantidad')
    subcategoria_id = request.form.get('subcategoria_id')

    if not id or not nombre or not unidad or not cantidad or not subcategoria_id:
        return jsonify({'error': 'Faltan datos requeridos'}), 400

    imagen_path = None
    if 'imagen' in request.files:
        imagen = request.files['imagen']
        if imagen.filename != '':
            basepath = os.path.dirname(__file__)
            filename = secure_filename(imagen.filename)
            extension = os.path.splitext(filename)[1]
            new_filename = "consumible_" + filename
            upload_path = os.path.join(basepath, 'uploads', new_filename)
            imagen.save(upload_path)
            imagen_path = "uploads/" + new_filename

    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)

    if imagen_path:
        cursor.execute("""
            UPDATE consumibles
            SET nombre = %s, unidad = %s, cantidad = %s, imagen = %s, subcategoria_id = %s
            WHERE id = %s
        """, (nombre, unidad, cantidad, imagen_path, subcategoria_id, id))
    else:
        cursor.execute("""
            UPDATE consumibles
            SET nombre = %s, unidad = %s, cantidad = %s, subcategoria_id = %s
            WHERE id = %s
        """, (nombre, unidad, cantidad, subcategoria_id, id))

    mysql.connection.commit()
    cursor.close()

    return jsonify({'message': 'Consumible modificado exitosamente'}), 200

# eliminar categoria CASCADE

@app.route("/categoria", methods=["DELETE"])
def eliminar_categoria():
    id = request.args.get('id')
    cursor = mysql.connection.cursor()
    cursor.execute("DELETE FROM categorias WHERE id = %s", id)
    
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Categoría eliminada exitosamente'}), 200

# eliminar subcategoria CASCADE
@app.route("/subcategoria", methods=["DELETE"])
def eliminar_subcategoria():
    id = request.args.get('id')
    cursor = mysql.connection.cursor()
    cursor.execute("DELETE FROM subcategorias WHERE id = %s", id)
    
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Subcategoría eliminada exitosamente'}), 200

# eliminar tipo_herramienta CASCADE
@app.route("/tipo-herramienta", methods=["DELETE"])
def eliminar_tipo():
    id = request.args.get('id')
    cursor = mysql.connection.cursor()
    cursor.execute("DELETE FROM subcategorias WHERE id = %s", id)
    
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Subcategoría eliminada exitosamente'}), 200


# eliminar consumible
@app.route("/consumible", methods=["DELETE"])
def eliminar_consumible():
    id = request.args.get('id')
    cursor = mysql.connection.cursor()
    cursor.execute("DELETE FROM consumibles WHERE id = %s", id)
    
    mysql.connection.commit()
    cursor.close()
    
    return jsonify({'message': 'Consumible eliminado exitosamente'}), 200


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

# PROBAR LA BD CASCADE, LOS ENDPOINTS DELETE