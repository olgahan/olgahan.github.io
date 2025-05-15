// Global variables to store model data
let modelData = null;

// Load the model data when the page loads
document.addEventListener('DOMContentLoaded', function() {
    // Listen for form submission
    document.getElementById('prediction-form').addEventListener('submit', function(e) {
        e.preventDefault();
        makePrediction();
    });
    
    // Load the model data
    loadModelData();
});

// Function to load model data
async function loadModelData() {
    try {
        const response = await fetch('model_data.json');
        if (!response.ok) {
            throw new Error('Failed to load model data');
        }
        modelData = await response.json();
        console.log('Model data loaded successfully');
    } catch (error) {
        console.error('Error loading model data:', error);
        showError('Error loading model data. Please try again later.');
    }
}

// Function to make a prediction
function makePrediction() {
    // Hide any previous results or errors
    document.getElementById('result').style.display = 'none';
    document.getElementById('error').style.display = 'none';
    document.getElementById('loading').style.display = 'block';
    
    // Check if model data is loaded
    if (!modelData) {
        showError('Model not loaded yet. Please try again in a moment.');
        return;
    }
    
    try {
        // Get input values
        const features = [];
        for (const featureName of modelData.feature_names) {
            const value = parseFloat(document.getElementById(featureName).value);
            if (isNaN(value)) {
                throw new Error(`Invalid value for ${featureName}`);
            }
            features.push(value);
        }
        
        // Make prediction using the loaded model
        const prediction = predictWithModel(features);
        
        // Display the result
        document.getElementById('prediction-value').textContent = prediction;
        
        // Update feature list
        const featureList = document.getElementById('feature-list');
        featureList.innerHTML = '';
        for (let i = 0; i < features.length; i++) {
            const li = document.createElement('li');
            li.innerHTML = `<strong>${modelData.feature_names[i].replace('_', ' ').replace(/\b\w/g, l => l.toUpperCase())}:</strong> ${features[i]} cm`;
            featureList.appendChild(li);
        }
        
        // Show the result
        document.getElementById('loading').style.display = 'none';
        document.getElementById('result').style.display = 'block';
    } catch (error) {
        console.error('Error making prediction:', error);
        showError(error.message || 'Error making prediction');
    }
}

// Function to predict using the random forest model
function predictWithModel(features) {
    // Initialize class vote counts
    const votes = new Array(modelData.n_classes).fill(0);
    
    // For each tree in the forest
    for (const tree of modelData.forest) {
        // Get the prediction from this tree
        const treeVotes = predictWithTree(tree, features);
        
        // Find the class with the most votes in this tree
        let maxIndex = 0;
        for (let i = 1; i < treeVotes.length; i++) {
            if (treeVotes[i] > treeVotes[maxIndex]) {
                maxIndex = i;
            }
        }
        
        // Add a vote for this class
        votes[maxIndex]++;
    }
    
    // Find the class with the most votes
    let predictedClass = 0;
    for (let i = 1; i < votes.length; i++) {
        if (votes[i] > votes[predictedClass]) {
            predictedClass = i;
        }
    }
    
    // Return the class name
    return modelData.target_names[predictedClass];
}

// Function to predict using a single decision tree
function predictWithTree(tree, features) {
    // Start from the root node
    let nodeId = 0;
    
    // Traverse the tree until we reach a leaf node
    while (true) {
        const node = tree[nodeId];
        
        // If it's a leaf node (feature_index is -1), return the value
        if (node.feature_index === -1) {
            return node.value;
        }
        
        // Otherwise, go left or right based on the feature value
        const featureValue = features[node.feature_index];
        if (featureValue <= node.threshold) {
            nodeId = node.children_left;
        } else {
            nodeId = node.children_right;
        }
    }
}

// Function to show an error message
function showError(message) {
    const errorElement = document.getElementById('error');
    errorElement.textContent = message;
    errorElement.style.display = 'block';
    document.getElementById('loading').style.display = 'none';
}
