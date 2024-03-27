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
        assert_eq!(rect_area(0, 1), None);
        assert_eq!(rect_area(1, 0), None);

        assert_eq!(rect_area(1, 1), Some(1));

        assert_eq!(rect_area(2, 1), Some(2));
        assert_eq!(rect_area(1, 2), Some(2));

        let max = u8::MAX;
        assert_eq!(rect_area(max, max), Some(max as u64 * max as u64));

        //assert_eq!(calculate_rectangle_area(max, max + 1), None);
        //assert_eq!(calculate_rectangle_area(1 + max, max), None);
    }

    #[test]
    fn test_equivalence_class_partitioning() {
        assert_eq!(rect_area(2, 3), Some(6));
        assert_eq!(rect_area(5, 4), Some(20));

        assert_eq!(rect_area(0, 5), None);
        assert_eq!(rect_area(7, 0), None);

        assert_eq!(rect_area(0, 0), None);

        //assert_eq!(calculate_rectangle_area(0, -3), None);
        //assert_eq!(calculate_rectangle_area(-2, -3), None);
    }
}
