public class FormatArray {
	public static String[] format(java.text.DecimalFormat fmt,double[] d) {
		String[] result=new String[d.length];
		for (int i = 0; i < d.length; i++)
			result[i] = fmt.format(d[i]);
		return result;
	}
}
