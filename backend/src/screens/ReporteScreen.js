// src/screens/ReporteScreen.js

import React, { useState, useEffect } from 'react';
import { View, Text, Image, ScrollView, StyleSheet, ActivityIndicator } from 'react-native';

const ReporteScreen = ({ route }) => {
    const { reporteId } = route.params;

    const [reporte, setReporte] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchReporte = async () => {
            try {
                // Reemplaza 'http://tu-api.com' con la URL de tu backend
                const response = await fetch(`http://http://localhost:3000/`);
                if (!response.ok) {
                    throw new Error('No se pudo cargar el reporte');
                }
                const data = await response.json();
                setReporte(data);
            } catch (err) {
                setError(err.message);
            } finally {
                setLoading(false);
            }
        };

        fetchReporte();
    }, [reporteId]);

    if (loading) {
        return <ActivityIndicator size="large" color="#0000ff" />;
    }

    if (error) {
        return <Text>Error: {error}</Text>;
    }

    // Aquí el componente de renderizado del reporte
    // ... (el resto del código que ya tienes)
};

const styles = StyleSheet.create({
    // ... (los estilos que ya tienes)
});

export default ReporteScreen;