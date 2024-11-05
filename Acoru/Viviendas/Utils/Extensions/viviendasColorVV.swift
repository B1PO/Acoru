    //
    //  viviendasColor.swift
    //  Acoru
    //
    //  Created by Mauricio Betancourt Mora on 14/10/24.
    //
    import SwiftUI

    struct ColorVariant {
        let normal: UIColor
        let dark: UIColor
        let darkMedium: UIColor
    }

    struct ColorPaletteVV {
        // Colores definidos para cada ícono
        static let agua = ColorVariant(
            normal: UIColor(
                red: 0.63,
                green: 0.84,
                blue: 0.61,
                alpha: 1.00
            ),  // Color para "Gota"
            dark: UIColor(
                red: 0.49,
                green: 0.76,
                blue: 0.46,
                alpha: 1.00
            ),
            darkMedium: UIColor(
                red: 0.49, green: 0.76, blue: 0.46, alpha: 0.29)
        )
        static let residuos = ColorVariant(
            normal: UIColor(
                red: 0.38, green: 0.75, blue: 0.93,
                alpha: 1.00
            ),
            dark:
                UIColor(
                    red: 0.18,
                    green: 0.65,
                    blue: 0.87,
                    alpha: 1.00
                ),
            darkMedium: UIColor(
                red: 0.18, green: 0.65, blue: 0.87, alpha: 0.29)
        )
        static let electricidad = ColorVariant(
            // Color para "Trash"
            normal: UIColor(
                red: 0.99,
                green: 0.76,
                blue: 0.35,
                alpha: 1.00
            ),
            dark: UIColor(
                red: 0.99,
                green: 0.66,
                blue: 0.35,
                alpha: 1.00
            ),
            darkMedium: UIColor(
                red: 0.99, green: 0.66, blue: 0.35,
                alpha: 0.29)
        )
        static let gris = ColorVariant(
            normal: UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1.0),
            dark: UIColor(red: 0.76, green: 0.77, blue: 0.78, alpha: 1.0),  // Versión más oscura
            darkMedium: UIColor(red: 0.86, green: 0.87, blue: 0.88, alpha: 1.0)  // Versión intermedia oscura
        )
        static let materiales = ColorVariant(
            normal: UIColor(
                red: 0.69, green: 0.74, blue: 0.77, alpha: 1.00
            ),  // Color gris claro para "Materiales"
            dark: UIColor(
                red: 0.54, green: 0.59, blue: 0.62, alpha: 1.00
            ),
            darkMedium: UIColor(
                red: 0.54, green: 0.59, blue: 0.62, alpha: 0.29
            )
        )

        static let zonas = ColorVariant(
            normal: UIColor(
                red: 0.30, green: 0.75, blue: 0.31, alpha: 1.00
            ),  // Color verde para "Zonas"
            dark: UIColor(
                red: 0.24, green: 0.60, blue: 0.25, alpha: 1.00
            ),
            darkMedium: UIColor(
                red: 0.24, green: 0.60, blue: 0.25, alpha: 0.29
            )
        )

        static let recursosNaturales = ColorVariant(
            normal: UIColor(
                red: 0.13, green: 0.59, blue: 0.95, alpha: 1.00
            ),  // Color azul para "Recursos Naturales"
            dark: UIColor(
                red: 0.10, green: 0.47, blue: 0.75, alpha: 1.00
            ),
            darkMedium: UIColor(
                red: 0.10, green: 0.47, blue: 0.75, alpha: 0.29
            )
        )

    }

    // Función para generar un color más claro
    func lighterColor(color: Color, percentage: Double) -> Color {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return Color(
            red: Double(min(red + percentage, 1.0)),
            green: Double(min(green + percentage, 1.0)),
            blue: Double(min(blue + percentage, 1.0))
        )
    }
