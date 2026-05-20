# BMI Health Tracker - 3-Tier Web Application

A full-stack health tracking application that calculates Body Mass Index (BMI), Basal Metabolic Rate (BMR), and daily calorie recommendations. Built with modern technologies and deployed on AWS infrastructure.

## 📋 Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [Project Structure](#project-structure)
- [API Endpoints](#api-endpoints)
- [Frontend Features](#frontend-features)
- [Database Schema](#database-schema)
- [Environment Variables](#environment-variables)
- [Deployment](#deployment)
- [Running the Application](#running-the-application)
- [Development](#development)
- [Contributing](#contributing)

## ✨ Features

- **Health Metrics Calculation**
  - BMI (Body Mass Index) with health category classification
  - BMR (Basal Metabolic Rate)
  - Daily calorie recommendations based on activity level
  
- **Measurement Tracking**
  - Record health measurements (weight, height, age, sex, activity level)
  - Store historical measurement data
  - Track measurements over time with timestamps

- **Trend Analysis**
  - View 30-day BMI trend charts
  - Visual representation of health progress
  - Average BMI calculations

- **Responsive UI**
  - Modern React-based frontend
  - Interactive forms for data entry
  - Real-time chart visualizations
  - Mobile-friendly design

## 🏗️ Architecture

This is a **3-tier architecture** application:

```
┌─────────────────────────────────────────────────────────────┐
│                    Frontend (React + Vite)                  │
│              User Interface & Charts (Port 5173)            │
└────────────────────┬────────────────────────────────────────┘
                     │ HTTP/REST API
                     ↓
┌─────────────────────────────────────────────────────────────┐
│             Backend (Express.js + Node.js)                  │
│         API Server & Business Logic (Port 3000)             │
└────────────────────┬────────────────────────────────────────┘
                     │ SQL Queries
                     ↓
┌─────────────────────────────────────────────────────────────┐
│              Database (PostgreSQL)                          │
│            Data Persistence & Storage                      │
└─────────────────────────────────────────────────────────────┘
```

**Infrastructure (AWS)**
- Terraform for Infrastructure as Code (IaC)
- VPC with public and private subnets
- Bastion host for secure access
- EC2 instances for backend
- RDS/PostgreSQL for database
- Security groups for network isolation

## 🛠️ Tech Stack

### Frontend
- **React** 18.2.0 - UI framework
- **Vite** 5.0.0 - Build tool & dev server
- **Axios** 1.4.0 - HTTP client
- **Chart.js** & **react-chartjs-2** - Data visualization

### Backend
- **Node.js** - Runtime environment
- **Express.js** 4.18.2 - Web framework
- **PostgreSQL** 14+ - Database
- **pg** 8.10.0 - PostgreSQL client
- **CORS** 2.8.5 - Cross-origin resource sharing
- **dotenv** 16.0.0 - Environment variable management
- **Body-parser** 1.20.2 - Request parsing

### DevOps & Deployment
- **Terraform** - Infrastructure as Code
- **PM2** - Process manager (production)
- **Nodemon** - Development auto-reload
- **GitHub Actions** - CI/CD pipeline

## 📦 Prerequisites

- **Node.js** v16.0.0 or higher
- **npm** v8.0.0 or higher
- **PostgreSQL** v14.0 or higher
- **Terraform** v1.15.0 or higher (for AWS deployment)
- **AWS Account** with appropriate permissions (for cloud deployment)
- **Git** for version control

## 🚀 Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd 3tier-webapp-github-actions
```

### 2. Database Setup

#### Option A: Local PostgreSQL Setup

```bash
cd database
sudo chmod +x setup-database.sh
sudo ./setup-database.sh
```

This script will:
- Install PostgreSQL (if needed)
- Create database and user
- Run migrations
- Set up required tables and indexes

#### Option B: Manual Database Setup

```sql
-- Create database and user
CREATE USER bmi_user WITH PASSWORD 'your_password';
CREATE DATABASE bmidb OWNER bmi_user;

-- Connect to the database
\c bmidb

-- Run migrations
\i path/to/001_create_measurements.sql
\i path/to/002_add_measurement_date.sql
```

### 3. Backend Setup

```bash
cd backend
npm install
```

Create `.env` file in `backend/` directory:

```env
DATABASE_URL=postgresql://bmi_user:your_password@localhost:5432/bmidb
PORT=3000
NODE_ENV=development
FRONTEND_URL=http://localhost:5173
```

### 4. Frontend Setup

```bash
cd frontend
npm install
```

Create `.env` file in `frontend/` directory:

```env
VITE_API_URL=http://localhost:3000/api
```

## 📁 Project Structure

```
3tier-webapp-github-actions/
├── backend/                          # Node.js/Express API
│   ├── src/
│   │   ├── server.js                # Express app setup
│   │   ├── routes.js                # API endpoints
│   │   ├── db.js                    # Database connection
│   │   └── calculations.js          # BMI/BMR calculations
│   ├── migrations/
│   │   ├── 001_create_measurements.sql
│   │   └── 002_add_measurement_date.sql
│   ├── ecosystem.config.js          # PM2 configuration
│   └── package.json
│
├── frontend/                         # React application
│   ├── src/
│   │   ├── App.jsx                  # Main app component
│   │   ├── api.js                   # API client
│   │   ├── main.jsx                 # Entry point
│   │   ├── index.css                # Styles
│   │   └── components/
│   │       ├── MeasurementForm.jsx  # Form for data entry
│   │       └── TrendChart.jsx       # Chart visualization
│   ├── index.html
│   ├── vite.config.js
│   └── package.json
│
├── database/                        # Database setup scripts
│   └── setup-database.sh            # Automated DB setup
│
├── terraform-for-aws-infra/         # AWS Infrastructure as Code
│   ├── main.tf                      # Main Terraform config
│   ├── variables.tf                 # Variable definitions
│   ├── terraform.tfvars.backup      # Variables template
│   └── modules/
│       ├── vpc/                     # Virtual Private Cloud
│       ├── security_groups/         # Network security
│       ├── bastion/                 # Bastion host
│       ├── backend/                 # Backend instances
│       └── database/                # RDS database
│
└── README.md                        # This file
```

## 🔌 API Endpoints

All API endpoints are prefixed with `/api`:

### POST `/api/measurements`
Create a new health measurement.

**Request Body:**
```json
{
  "weightKg": 75.5,
  "heightCm": 180,
  "age": 30,
  "sex": "male",
  "activity": "moderate",
  "measurementDate": "2026-05-20"
}
```

**Parameters:**
- `weightKg` (number, required): Weight in kilograms (0 < weight < 1000)
- `heightCm` (number, required): Height in centimeters (0 < height < 300)
- `age` (number, required): Age in years (0 < age < 150)
- `sex` (string, required): "male" or "female"
- `activity` (string, optional): "sedentary", "light", "moderate", "active", or "very_active" (default: "sedentary")
- `measurementDate` (string, optional): Date in YYYY-MM-DD format (default: today)

**Response:** Returns the created measurement with calculated BMI, BMR, and daily calories.

### GET `/api/measurements`
Retrieve all measurements.

**Response:**
```json
{
  "rows": [
    {
      "id": 1,
      "weight_kg": 75.5,
      "height_cm": 180,
      "age": 30,
      "sex": "male",
      "activity_level": "moderate",
      "bmi": 23.3,
      "bmi_category": "Normal",
      "bmr": 1680,
      "daily_calories": 2604,
      "measurement_date": "2026-05-20",
      "created_at": "2026-05-20T10:30:00Z"
    }
  ]
}
```

### GET `/api/measurements/trends`
Get 30-day BMI trend data.

**Response:**
```json
{
  "rows": [
    {
      "day": "2026-04-20",
      "avg_bmi": 23.5
    }
  ]
}
```

### GET `/health`
Health check endpoint.

**Response:**
```json
{
  "status": "ok",
  "environment": "production"
}
```

## 🎨 Frontend Features

### MeasurementForm Component
- Input form for health measurements
- Validation for positive numbers
- Activity level selector
- Date picker for measurement date
- Submit button to save measurements

### TrendChart Component
- Line chart displaying 30-day BMI trends
- Real-time data updates
- Interactive chart with Chart.js

### Main App Component
- Display list of all measurements
- Loading states and error handling
- Auto-refresh capability
- Responsive layout

## 💾 Database Schema

### measurements Table

```sql
CREATE TABLE measurements (
  id SERIAL PRIMARY KEY,
  weight_kg NUMERIC(5,2) NOT NULL CHECK (weight_kg > 0 AND weight_kg < 1000),
  height_cm NUMERIC(5,2) NOT NULL CHECK (height_cm > 0 AND height_cm < 300),
  age INTEGER NOT NULL CHECK (age > 0 AND age < 150),
  sex VARCHAR(10) NOT NULL CHECK (sex IN ('male', 'female')),
  activity_level VARCHAR(30) CHECK (activity_level IN ('sedentary', 'light', 'moderate', 'active', 'very_active')),
  bmi NUMERIC(4,1) NOT NULL,
  bmi_category VARCHAR(30),
  bmr INTEGER,
  daily_calories INTEGER,
  measurement_date DATE NOT NULL DEFAULT CURRENT_DATE,
  created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);
```

**Indexes:**
- `idx_measurements_measurement_date` - For faster trend queries
- `idx_measurements_created_at` - For faster ordering
- `idx_measurements_bmi` - For BMI-based queries

## 🔐 Environment Variables

### Backend (.env)

```env
# Database Configuration
DATABASE_URL=postgresql://bmi_user:password@localhost:5432/bmidb

# Server Configuration
PORT=3000
NODE_ENV=development          # development or production

# CORS Configuration
FRONTEND_URL=http://localhost:5173
```

### Frontend (.env)

```env
# API Configuration
VITE_API_URL=http://localhost:3000/api
```

### AWS Terraform (terraform.tfvars)

```hcl
aws_region       = "us-east-1"
aws_Access_Key   = "YOUR_AWS_ACCESS_KEY"
aws_Secret_Key   = "YOUR_AWS_SECRET_KEY"
key_pair_name    = "your-key-pair-name"
# Additional variables as defined in variables.tf
```

## 🌐 Deployment

### AWS Deployment with Terraform

1. **Configure AWS credentials:**
   ```bash
   cd terraform-for-aws-infra
   cp terraform.tfvars.backup terraform.tfvars
   # Edit terraform.tfvars with your AWS credentials
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Plan deployment:**
   ```bash
   terraform plan
   ```

4. **Apply configuration:**
   ```bash
   terraform apply
   ```

This will create:
- VPC with public and private subnets
- Security groups for network isolation
- Bastion host for secure access
- Backend EC2 instances
- PostgreSQL database (RDS)

### Production Deployment on EC2

1. **Clone repository on EC2 instance**
2. **Run database setup script**
3. **Install Node.js and PM2:**
   ```bash
   sudo apt update
   sudo apt install nodejs npm
   sudo npm install -g pm2
   ```

4. **Configure environment variables**
5. **Start backend with PM2:**
   ```bash
   cd backend
   pm2 start ecosystem.config.js
   pm2 save
   pm2 startup
   ```

6. **Build and serve frontend:**
   ```bash
   cd frontend
   npm run build
   # Serve from static web server or reverse proxy
   ```

## ▶️ Running the Application

### Development Mode

**Terminal 1 - Start Backend:**
```bash
cd backend
npm run dev
# Server will run on http://localhost:3000
```

**Terminal 2 - Start Frontend:**
```bash
cd frontend
npm run dev
# Frontend will run on http://localhost:5173
```

**Terminal 3 - Start Database (if not running):**
```bash
sudo service postgresql start
# Or: pg_ctl -D /usr/local/var/postgres start
```

### Production Mode

**Backend:**
```bash
cd backend
npm run start
# Or with PM2: pm2 start ecosystem.config.js
```

**Frontend:**
```bash
cd frontend
npm run build
# Serve dist/ folder with Nginx or Express static server
```

## 💻 Development

### Adding New Features

1. **Database Changes:** Create new migration files in `backend/migrations/`
   ```bash
   # Format: XXX_description.sql
   # Example: 003_add_user_table.sql
   ```

2. **API Endpoints:** Add routes in `backend/src/routes.js`

3. **Frontend Components:** Create React components in `frontend/src/components/`

4. **Calculations:** Update logic in `backend/src/calculations.js`

### Code Style & Best Practices

- Use meaningful variable and function names
- Add comments for complex logic
- Validate user inputs on both frontend and backend
- Use prepared statements to prevent SQL injection
- Handle errors gracefully with proper status codes

### Testing

Run tests with your preferred testing framework:

```bash
# For backend
cd backend
npm test

# For frontend
cd frontend
npm test
```

## 📊 BMI & Health Calculations

### BMI Formula
```
BMI = weight (kg) / height (m)²
```

**Categories:**
- Underweight: BMI < 18.5
- Normal: 18.5 ≤ BMI < 25
- Overweight: 25 ≤ BMI < 30
- Obese: BMI ≥ 30

### BMR (Basal Metabolic Rate) Formula

**Males:**
```
BMR = (10 × weight) + (6.25 × height) - (5 × age) + 5
```

**Females:**
```
BMR = (10 × weight) + (6.25 × height) - (5 × age) - 161
```

### Daily Calorie Calculation
```
Daily Calories = BMR × Activity Multiplier
```

**Activity Multipliers:**
- Sedentary: 1.2 (little or no exercise)
- Light: 1.375 (exercise 1-3 days/week)
- Moderate: 1.55 (exercise 3-5 days/week)
- Active: 1.725 (exercise 6-7 days/week)
- Very Active: 1.9 (intense exercise 6-7 days/week)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is part of the OSTAD M6 curriculum. Check with your instructor for licensing details.

## 📧 Support

For issues, questions, or feature requests, please open an issue in the repository or contact the development team.

---

**Last Updated:** May 2026
**Version:** 1.0.0
