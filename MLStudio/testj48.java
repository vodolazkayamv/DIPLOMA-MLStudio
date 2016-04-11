//Generated JAVA file
import weka.core.Instance;
import weka.core.Instances;
import weka.core.converters.ArffLoader;
import java.io.File;


import weka.core.converters.ConverterUtils.DataSource;
import weka.core.Utils;
import weka.classifiers.Classifier;
import weka.classifiers.Evaluation;


import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.meta.AdaBoostM1;
import weka.classifiers.trees.J48;

public class testj48 {
    public static void main(String[] args) throws Exception {
        ///////////////////////////////////////////////////////////
        // java testj48 -W "weka.classifiers.trees.J48 -C 0.25"  //
        ///////////////////////////////////////////////////////////

        Instances data = DataSource.read("contact-lenses.arff");

        ////////////////////////////////////////////////////////////
        // setting CLASS attribute (att to use in classification) //
        ////////////////////////////////////////////////////////////

        String clsIndex = "last";

        if (clsIndex.length() == 0)
            clsIndex = "last";
        if (clsIndex.equals("first"))
            data.setClassIndex(0);
        else if (clsIndex.equals("last"))
            data.setClassIndex(data.numAttributes() - 1);
        else
            data.setClassIndex(Integer.parseInt(clsIndex) - 1);
       
        ////////////////
        // classifier //
        ////////////////
        String[] tmpOptions;
        String classname;
        tmpOptions     = Utils.splitOptions(Utils.getOption("W", args));
        classname      = tmpOptions[0];
        //classname = "J48";
        //System.out.println(classname);
        tmpOptions[0]  = "";
        //for (int i = 0; i < tmpOptions.length; i++)
        //{   System.out.println(tmpOptions[i]);}
        Classifier cls = (Classifier) Utils.forName(Classifier.class, classname, tmpOptions);

        //System.out.println();

        // output evaluation
        System.out.println();
        System.out.println("=== Setup ===");
        System.out.println("Classifier: " + cls.getClass().getName() + " " + Utils.joinOptions(cls.getOptions()));
        System.out.println("Dataset: " + data.relationName());
        System.out.println();
        // model output
        cls.buildClassifier(data);
        System.out.println(cls);

    }
}