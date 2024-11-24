from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
import pandas as pd
import numpy as np
import tensorflow as tf
import os

app = Flask(__name__)
CORS(app)

# Load the trained model when the app starts
model = tf.keras.models.load_model('./model2.h5')

def predict_size(weight, age, height):
    # Predict the size based on input features
    user_input = pd.DataFrame({'Weight': [weight], 'Age': [age], 'Height': [height]})
    prediction = model.predict(user_input)
    size_labels = {0: 'XXXL', 1: 'XXL', 2: 'XL', 3: 'L', 4: 'M', 5: 'S', 6: 'XXS'}
    predicted_size = size_labels[np.argmax(prediction)]
    return predicted_size

@app.route('/')
def home():
    return render_template('index.html')  # Serve the HTML form

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Fetch input values
        weight = float(request.form.get('weight', 0))
        age = int(request.form.get('age', 0))
        height = float(request.form.get('height', 0))

        # Validate inputs are positive
        if weight <= 0 or age <= 0 or height <= 0:
            return jsonify({'error': 'Please provide positive values for weight, age, and height.'}), 400

        # Make prediction
        prediction = predict_size(weight, age, height)
        return jsonify({'prediction': prediction})

    except (ValueError, TypeError) as e:
        # Return an error response for invalid data types
        return jsonify({'error': 'Invalid input. Ensure weight, age, and height are numbers.'}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080, debug=True)  # Changed port to 8080
