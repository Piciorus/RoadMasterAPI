#[cfg(test)]
mod tests {

    pub fn rect_area(length: u8, width: u8) -> Option<u64> {
        if length == 0 || width == 0 {
            None
        } else {
            Some((length as u64 * width as u64).into())
        }
    }

    #[test]
    fn test_boundary_value_analysis() {
        // sub limita inferioara
        assert_eq!(rect_area(0, 1), None);
        assert_eq!(rect_area(1, 0), None);

        //limita inferioara
        assert_eq!(rect_area(1, 1), Some(1));

        //limita inferioara + 1
        assert_eq!(rect_area(2, 1), Some(2));
        assert_eq!(rect_area(1, 2), Some(2));

        let max = u8::MAX;

        //limita superioara -1
        assert_eq!(
            rect_area(max - 1, max - 1),
            Some((max - 1) as u64 * (max - 1) as u64)
        );

        // limmita superioara
        assert_eq!(rect_area(max, max), Some(max as u64 * max as u64));

        // limita superiora + 1 | nepermis de compiler
        //assert_eq!(calculate_rectangle_area(max, max + 1), None);
        //assert_eq!(calculate_rectangle_area(1 + max, max), None);
    }

    #[test]
    fn test_equivalence_class_partitioning() {
        // clasa numerelor pozitive
        assert_eq!(rect_area(2, 3), Some(6));
        assert_eq!(rect_area(5, 4), Some(20));

        // clasa 0 cu pozitiv | pozitiv cu 0
        assert_eq!(rect_area(0, 5), None);
        assert_eq!(rect_area(7, 0), None);

        // clasa 0 | 0
        assert_eq!(rect_area(0, 0), None);

        // clasele de mai sus, dar negative | nepermise de compiler

        //assert_eq!(calculate_rectangle_area(-2, -3), None);

        //assert_eq!(calculate_rectangle_area(0, -3), None);
        //assert_eq!(calculate_rectangle_area(-3, 0), None);
    }
}
