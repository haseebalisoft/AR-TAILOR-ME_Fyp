from flask import Flask, request, jsonify, render_template
from flask_cors import CORS
import numpy as np
import joblib

app = Flask(__name__)
CORS(app)

# Load the KNN model and scaler at the start
knn_model = joblib.load("knn_model.pkl")
scaler = joblib.load("scaler.pkl")

def knn_predict_size(weight, age, height):
    # Prepare the data for the KNN model
    new_data = np.array([[age, weight, height, height * weight, weight * weight]])
    new_data_scaled = scaler.transform(new_data)
    prediction = knn_model.predict(new_data_scaled)
    size_labels = {0: 'XXXL', 1: 'XXL', 2: 'XL', 3: 'L', 4: 'M', 5: 'S', 6: 'XXS'}
    predicted_size = size_labels[prediction[0]]
    return predicted_size

@app.route('/')
def home():
    return render_template('index.html')  # Serve the HTML form

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Fetch input values from the form
        weight = float(request.form.get('weight', 0))
        age = int(request.form.get('age', 0))
        height = float(request.form.get('height', 0))

        # Validate inputs are positive
        if weight <= 0 or age <= 0 or height <= 0:
            return jsonify({'error': 'Please provide positive values for weight, age, and height.'}), 400

        # Make prediction using KNN model
        prediction = knn_predict_size(weight, age, height)
        return jsonify({'prediction': prediction})

    except (ValueError, TypeError) as e:
        # Handle invalid data
        return jsonify({'error': 'Invalid input. Ensure weight, age, and height are numbers.'}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8081, debug=True)  # Start the app on port 8080
